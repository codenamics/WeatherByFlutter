import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/CurrentWeather.dart';
import 'package:weather/common/format.dart';

class CurrentWeatherUI extends StatelessWidget {
  final double appBarHeight = 66.0;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    Formats formats = Formats();
    var weatherData = Provider.of<CurrentWeatherProvider>(context).currentData;
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(weatherData.cityName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 40.0)),
                ),
                Container(
                  child: Text(formats.floatin(weatherData.temp),
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 50.0)),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(weatherData.description,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Poppins',
                            fontSize: 30.0)),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.blueAccent, Colors.blue],
        ),
      ),
    );
  }
}
