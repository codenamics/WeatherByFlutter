import 'package:flutter/material.dart';
import 'package:weather/models/ForcastMain.dart';
import 'package:weather/models/ForcastWeather.dart';

class Forcast {
  int dt;
  ForcastWeather weather;
  ForcastMain main;

  Forcast({
    @required this.dt,
    @required this.weather,
    @required this.main,
  });

  factory Forcast.fromJson(Map<String, dynamic> json) {
    return Forcast(
      dt: json['dt'] as int,
      weather: ForcastWeather.fromJson(json['weather'][0]),
      main: ForcastMain.fromJson(json['main']),
    );
  }
}
