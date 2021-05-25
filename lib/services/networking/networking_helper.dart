import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';

class NetworkingHelper {
  //Helper methods...

  Fruit decodeFruit(Map<String, dynamic> fruitJson) {
    List<Data> sales = [];
    List<Vitamins> vitamins = [];
    fruitJson['vitamins'].forEach((element) {
      vitamins.add(Vitamins.fromJson(element));
    });
    fruitJson['sales'].forEach((element) {
      sales.add(Data.fromJson(element));
    });

    fruitJson['vitamins'] = vitamins;
    fruitJson['sales'] = sales;

    return Fruit.fromJson(fruitJson);
  }

  Map<String, dynamic> encodeFruit(Fruit fruit) {
    Map<String, dynamic> fruitJson = fruit.toJson();

    List<Map<String, dynamic>> sales = [];
    List<Map<String, dynamic>> vitamins = [];

    fruitJson['vitamins'].forEach((Vitamins element) {
      vitamins.add(element.toJson());
    });

    fruitJson['sales'].forEach((Data element) {
      sales.add(element.toJson());
    });

    fruitJson['vitamins'] = vitamins;
    fruitJson['sales'] = sales;

    return fruitJson;
  }

  List<Fruit> fruitList(Map<String, dynamic> response) {
    print('fruits json - $response');

    List<Fruit> fruitList = [];
    List<dynamic> fruitListJson = response['data'];
    fruitListJson.forEach((fruitJson) {
      fruitList.add(decodeFruit(fruitJson));
    });

    return fruitList;
  }
}
