import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/service/LocationService.dart';

import 'dart:convert';

import '../models/CurrentWeather.dart';

class CurrentWeatherProvider with ChangeNotifier {
  CurrentWeather currentWeather = CurrentWeather();
  Location location = Location();
  String text;
  String apiKey = '4e2b39896dcc3622534cc498191bdc35';

  CurrentWeather _currentWeatherData;

  CurrentWeather get currentData {
    return _currentWeatherData;
  }

  Future<void> getData(text) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$text&appid=$apiKey&units=metric');

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      var responseData = CurrentWeather.fromJson(data);
      _currentWeatherData = responseData;
    } else {
      return [];
    }
    notifyListeners();
  }

  Future<void> getDataLocation() async {
    await location.getCurrentLocation();
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      print(data);
      var responseData = CurrentWeather.fromJson(data);
      _currentWeatherData = responseData;
    } else {
      return [];
    }
    notifyListeners();
  }
}
