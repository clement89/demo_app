import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddItemViewModel extends ChangeNotifier {
  Fruit fruit;
  bool isLoading = false;
  String message = '';

  final WebApiClient _apiClient = WebApiClient(httpClient: http.Client());

  void initialize() {
    fruit = Fruit(0, '', [], [], []);
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  void addVitamin(List<Vitamins> data) {
    fruit.vitamins = data;
    notifyListeners();
  }

  void addData({List<Data> data, bool isSales}) {
    if (isSales) {
      fruit.sales = data;
    } else {
      fruit.availabilities = data;
    }
    notifyListeners();
  }

  Future creteNewFruit() async {
    isLoading = true;
    notifyListeners();

    message = await _apiClient.createFruit(fruit: fruit);
    isLoading = false;
    notifyListeners();
  }

  void showErrorMessage(String error) {}
}
