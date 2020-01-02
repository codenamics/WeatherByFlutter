import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/service/LocationService.dart';
import 'dart:convert';
import '../models/Forcast.dart';

class ForcastWeatherProvider with ChangeNotifier {
  String apiKey = '4e2b39896dcc3622534cc498191bdc35';
  Location location = Location();
  List<Forcast> _forcastWeatherData = [];

  List<Forcast> get forcastWeatherData {
    return [..._forcastWeatherData];
  }

  Future<void> getForcast(text) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?q=$text&units=metric&appid=$apiKey');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      final forcast = (data['list'] as List).map((i) => Forcast.fromJson(i));
      _forcastWeatherData = forcast.toList();
    } else {
      return [];
    }
  }

  Future<void> getForcastLocation() async {
    await location.getCurrentLocation();
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      final forcast =
          (data['list'] as List).map((i) => new Forcast.fromJson(i));
      _forcastWeatherData = forcast.toList();
    } else {
      return [];
    }
    notifyListeners();
  }
}
