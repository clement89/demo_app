import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/services/networking/networking_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WebApiClient {
  final http.Client httpClient;
  WebApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  //Define base url

  final String _baseUrl =
      'https://0b3e39d6-8e08-4b48-a62e-7bbc9233245c.mock.pstmn.io/api';
  final NetworkingHelper _helper = NetworkingHelper();

  //Define methods

  //Get...
  Future<Either<String, List<Fruit>>> loadAllFruits() async {
    try {
      final url = '$_baseUrl/fruits/';
      final response = await httpClient.get(Uri.parse(url),
          headers: <String, String>{'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        // print(parsed);
        return Right(_helper.fruitList(parsed));
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
          body: json.encode(_helper.encodeFruit(fruit)),
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

  //Edit

  Future<String> edit({Fruit fruit, int id}) async {
    try {
      final url = '$_baseUrl/fruits/$id';
      final response = await http.put(Uri.parse(url),
          body: json.encode(_helper.encodeFruit(fruit)),
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
}
