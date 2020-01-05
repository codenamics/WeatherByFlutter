import 'package:flutter/material.dart';

import 'package:weather/common/format.dart';

import 'package:weather/widgets/CurrentWeatherUI.dart';
import 'package:weather/widgets/ForcastWeatherUI.dart';

class Weather extends StatefulWidget {
  static const routeName = '/main-tasks-screen';

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Formats formats = Formats();
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CurrentWeatherUI(),
              ];
            },
            body: ForcastWeatherUI()));
  }
}
