import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WebApiClient {
  final http.Client httpClient;
  WebApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  //Define base url

  final String _baseUrl = 'http://e8111a28cbfb.ngrok.io/api';
  final int timeOut = 15;

  //Define methods

  //Get...
  Future<Either<String, List<Fruit>>> loadAllFruits() async {
    try {
      final url = '$_baseUrl/fruits/';
      final response = await httpClient.get(Uri.parse(url),
          headers: <String, String>{'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return Right(_fruitList(parsed));
      } else {
        return Left('Unable to fetch data from the REST API');
      }
    } on SocketException {
      return Left('No internet connection');
    }
  }

  //Create...

  Future<String> createFruit({Fruit fruit}) async {
    try {
      final url = '$_baseUrl/fruits/';
      final response = await http.post(Uri.parse(url),
          body: json.encode(encodeFruit(fruit)),
          headers: <String, String>{'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return ('Success');
      } else {
        return ('Unable to fetch data from the REST API');
      }
    } on SocketException {
      return ('No internet connection');
    }
  }

  //Delete...

  Future<String> deleteFruit({int id}) async {
    try {
      final url = '$_baseUrl/fruits/$id';
      final response = await http.delete(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'});

      print('response.statusCode - ${response.statusCode}');
      if (response.statusCode == 204) {
        return ('Success');
      } else {
        return ('Unable to fetch data from the REST API');
      }
    } on SocketException {
      return ('No internet connection');
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
