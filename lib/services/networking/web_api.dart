import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class WebApiClient {
  //Create single tone

  WebApiClient._privateConstructor();

  static final WebApiClient _instance = WebApiClient._privateConstructor();

  factory WebApiClient() {
    return _instance;
  }

  //Define base url

  final _baseUrl = 'http://5d65fea24cbf.ngrok.io/api';
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
        print(parsed);
        // successCallBack(Fruit.fromJson(parsed));
        successCallBack(parsed);
      } else {
        errorCallback('Unable to fetch data from the REST API');
      }
    } on SocketException {
      errorCallback('No internet connection');
    }
  }

  //Create...

  Future<void> createFruit({
    Map<String, dynamic> body,
    Function successCallBack,
    Function errorCallback,
  }) async {
    try {
      final url = '$_baseUrl/fruits/';
      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
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
}
