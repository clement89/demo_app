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

  Future creteNewFruit() async {
    isLoading = true;
    notifyListeners();

    await _apiClient.createFruit(
        fruit: fruit,
        successCallBack: () {},
        errorCallback: (String error) {
          showErrorMessage(error);
        });

    isLoading = false;
    notifyListeners();
  }

  void showErrorMessage(String error) {}
}
