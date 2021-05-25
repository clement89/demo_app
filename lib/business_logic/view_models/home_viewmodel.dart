import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  final WebApiClient _apiClient = WebApiClient(httpClient: http.Client());
  List<Fruit> fruitList = [];
  String message = '';
  Fruit selectedFruit;

  void loadData({Function errorHandler}) async {
    final apiResult = await _apiClient.loadAllFruits();
    apiResult.fold((error) {
      errorHandler(error);
    }, (fruits) {
      fruitList = fruits;
      if (selectedFruit == null && fruitList.isNotEmpty) {
        selectedFruit = fruitList.elementAt(0);
      }
      if (fruitList.isEmpty) {
        selectedFruit = null;
      }
      notifyListeners();
    });
  }

  void updateSelectedFruit(Fruit fruit) {
    selectedFruit = fruit;
    notifyListeners();
  }

  void addFruit(Fruit fruit) {
    fruitList.add(fruit);
    notifyListeners();
  }

  void showErrorMessage(String error) {
    notifyListeners();
  }

  Future deleteFruit(Fruit item) async {
    message = await _apiClient.deleteFruit(id: item.id);
    fruitList.remove(item);
    notifyListeners();
  }
}
