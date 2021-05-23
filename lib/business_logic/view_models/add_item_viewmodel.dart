import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter/cupertino.dart';

class AddItemViewModel extends ChangeNotifier {
  Fruit fruit;
  bool isLoading = false;

  final WebApiClient _apiClient = WebApiClient();

  void initialize() {
    fruit = Fruit(0, '', [], []);
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  void addVitamin(Vitamins vitamin) {
    fruit.vitamins.add(vitamin);
    notifyListeners();
  }

  void addSales(List<Sales> sales) {
    fruit.sales = sales;
    notifyListeners();
  }

  void creteNewFruit() async {
    isLoading = true;
    notifyListeners();

    Map<String, dynamic> fruitJson = fruit.toJson();

    List<Map<String, dynamic>> sales = [];
    List<Map<String, dynamic>> vitamins = [];

    print(fruitJson);

    fruitJson['vitamins'].forEach((Vitamins element) {
      vitamins.add(element.toJson());
    });

    fruitJson['sales'].forEach((Sales element) {
      sales.add(element.toJson());
    });

    fruitJson['vitamins'] = vitamins;
    fruitJson['sales'] = sales;

    print(fruitJson);

    await _apiClient.createFruit(
        body: fruitJson,
        successCallBack: () {},
        errorCallback: (String error) {
          showErrorMessage(error);
        });

    isLoading = false;
    notifyListeners();
  }

  void showErrorMessage(String error) {}
}
