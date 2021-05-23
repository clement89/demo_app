import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final WebApiClient _apiClient = WebApiClient();
  List<Fruit> fruitList;
  Fruit selectedFruit;

  void loadData() {
    print('loading all data');

    _apiClient.loadAllFruits(successCallBack: (Map<String, dynamic> response) {
      updateFruits(response);
    }, errorCallback: (String error) {
      showErrorMessage(error);
    });
  }

  void updateFruits(Map<String, dynamic> response) {
    fruitList = [];
    List<dynamic> fruitListJson = response['data'];

    fruitListJson.forEach((fruitJson) {
      List<Sales> sales = [];
      List<Vitamins> vitamins = [];
      fruitJson['vitamins'] = fruitJson['vitamins'].forEach((element) {
        vitamins.add(Vitamins.fromJson(element));
      });
      fruitJson['sales'] = fruitJson['sales'].forEach((element) {
        sales.add(Sales.fromJson(element));
      });

      fruitList.add(Fruit.fromJson(fruitJson));
    });
    if (fruitList.length > 0) {
      selectedFruit = fruitList.elementAt(0);
    }
    notifyListeners();
  }

  void showErrorMessage(String error) {
    notifyListeners();
  }
}
