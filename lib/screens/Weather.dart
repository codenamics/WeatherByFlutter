import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather/common/format.dart';
import 'package:weather/providers/CurrentWeather.dart';
import 'package:weather/providers/ForcastWeatherProvider.dart';

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
                SliverAppBar(
                  forceElevated: true,
                  expandedHeight: 220,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CurrentWeatherUI(),
                  ),
                ),
              ];
            },
            body: ForcastWeatherUI()));
  }
}
