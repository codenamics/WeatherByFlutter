import 'package:flutter/material.dart';

class Forcast {
  int dt;
  String main;
  ForcastMain temp;

  Forcast({
    @required this.dt,
    @required this.main,
    @required this.temp,
  });

  factory Forcast.fromJson(Map<String, dynamic> json) {
    return Forcast(
      dt: json['dt'] as int,
      main: json['weather'][0]['main'] as String,
      temp: ForcastMain.fromJson(json['main']),
    );
  }
}

class ForcastMain {
  double temp;

  ForcastMain({this.temp});

  factory ForcastMain.fromJson(Map<String, dynamic> json) {
    return ForcastMain(
      temp: json['temp'],
    );
  }
}
