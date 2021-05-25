import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  final WebApiClient _apiClient = WebApiClient(httpClient: http.Client());
  List<Fruit> fruitList = [];
  Fruit selectedFruit;
  String message = '';

  void loadData() async {
    final apiResult = await _apiClient.loadAllFruits();
    apiResult.fold((error) {}, (fruits) {
      fruitList = fruits;
      if (fruitList.length > 0) {
        updateSelectedFruit(fruitList.elementAt(0));
      } else {
        notifyListeners();
      }
    });
  }

  void updateSelectedFruit(Fruit fruit) {
    selectedFruit = fruit;
    notifyListeners();
  }

  void showErrorMessage(String error) {
    notifyListeners();
  }

  Future deleteFruit(Fruit item) async {
    message = await _apiClient.deleteFruit(id: item.id);
    notifyListeners();
  }
}
