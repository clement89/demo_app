import 'dart:convert';
import 'dart:io';

import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:http/http.dart' as http;

class WebApiClient {
  //Create single tone

  WebApiClient._privateConstructor();
  static final WebApiClient _instance = WebApiClient._privateConstructor();
  factory WebApiClient() {
    return _instance;
  }

  //Define base url

  final _baseUrl = 'http://b06862888fd6.ngrok.io/api';
  int timeOut = 15;

  //Define methods

  //Get...
  Future<void> loadAllFruits(
      {Function successCallBack, Function errorCallback}) async {
    try {
      final url = '$_baseUrl/fruits/';
      final response = await http.get(Uri.parse(url),
          headers: <String, String>{'Accept': 'application/json'}).timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          errorCallback('Request timeout.');
          return;
        },
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        successCallBack(_fruitList(parsed));
      } else {
        errorCallback('Unable to fetch data from the REST API');
      }
    } on SocketException {
      errorCallback('No internet connection');
    }
  }

  //Create...

  Future<void> createFruit({
    Fruit fruit,
    Function successCallBack,
    Function errorCallback,
  }) async {
    try {
      final url = '$_baseUrl/fruits/';
      final response = await http.post(Uri.parse(url),
          body: json.encode(encodeFruit(fruit)),
          headers: <String, String>{
            'Content-Type': 'application/json'
          }).timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          errorCallback('Request timeout.');
          return;
        },
      );
      if (response.statusCode == 200) {
        successCallBack();
      } else {
        errorCallback('Unable to fetch data from the REST API');
      }
    } on SocketException {
      errorCallback('No internet connection');
    }
  }

  //Delete...

  Future<void> deleteFruit({
    int id,
    Function successCallBack,
    Function errorCallback,
  }) async {
    try {
      final url = '$_baseUrl/fruits/$id';
      final response = await http.delete(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json'
          }).timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          errorCallback('Request timeout.');
          return;
        },
      );

      print('response.statusCode - ${response.statusCode}');
      if (response.statusCode == 204) {
        successCallBack();
      } else {
        errorCallback('Unable to fetch data from the REST API');
      }
    } on SocketException {
      errorCallback('No internet connection');
    }
  }

  //Helper methods...

  Fruit decodeFruit(Map<String, dynamic> fruitJson) {
    List<Sales> sales = [];
    List<Vitamins> vitamins = [];
    fruitJson['vitamins'].forEach((element) {
      vitamins.add(Vitamins.fromJson(element));
    });
    fruitJson['sales'].forEach((element) {
      sales.add(Sales.fromJson(element));
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

    fruitJson['sales'].forEach((Sales element) {
      sales.add(element.toJson());
    });

    fruitJson['vitamins'] = vitamins;
    fruitJson['sales'] = sales;

    return fruitJson;
  }

  List<Fruit> _fruitList(Map<String, dynamic> response) {
    print('fruits json - $response');

    List<Fruit> fruitList = [];
    List<dynamic> fruitListJson = response['data'];
    fruitListJson.forEach((fruitJson) {
      fruitList.add(decodeFruit(fruitJson));
    });

    return fruitList;
  }
}
