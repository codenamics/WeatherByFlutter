import 'package:flutter/material.dart';

class Forcast {
  int dt;
  String main;
  double temp;

  Forcast({
    @required this.dt,
    @required this.main,
    @required this.temp,
  });

  factory Forcast.fromJson(Map<String, dynamic> json) {
    return Forcast(
      dt: json['dt'] as int,
      main: json['weather'][0]['main'] as String,
      temp: json['main']['temp'].toDouble(),
    );
  }
}
