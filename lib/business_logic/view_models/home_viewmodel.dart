import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final WebApiClient _apiClient = WebApiClient();
  List<Fruit> fruitList = [];
  Fruit selectedFruit;
  String message = '';

  void loadData() {
    _apiClient.loadAllFruits(successCallBack: (List<Fruit> response) {
      updateFruits(response);
    }, errorCallback: (String error) {
      showErrorMessage(error);
    });
  }

  void updateFruits(List<Fruit> fruits) {
    if (fruits.length > 0) {
      selectedFruit = fruits.elementAt(0);
      fruitList = fruits;
    }
    notifyListeners();
  }

  void showErrorMessage(String error) {
    notifyListeners();
  }

  Future deleteFruit(Fruit item) async {
    await _apiClient.deleteFruit(
        id: item.id,
        successCallBack: () {
          fruitList.remove(item);
          message = 'Successfully deleted!';
        },
        errorCallback: (String error) {
          message = 'Error - ' + error;
        });
    notifyListeners();
  }
}
