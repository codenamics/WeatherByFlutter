import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.text});
  bool isLoading;
  String text;
  String apiKey = '4e2b39896dcc3622534cc498191bdc35';
  Future<dynamic> getData(text) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$text&appid=$apiKey&units=metric');

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
