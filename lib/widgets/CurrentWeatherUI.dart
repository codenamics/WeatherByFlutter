import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/common/format.dart';
import 'package:weather/providers/CurrentWeather.dart';

class CurrentWeatherUI extends StatelessWidget {
  const CurrentWeatherUI({
    @required this.formats,
    this.text,
    this.lat,
    this.lon,
  });

  final Formats formats;
  final String text;
  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context) {
    var weatherData = Provider.of<CurrentWeatherProvider>(context).currentData;
    print('sec');
    return weatherData == null
        ? CircularProgressIndicator
        : Container(
            margin: EdgeInsets.fromLTRB(12, 1, 30, 0),
            decoration: new BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD4DAF6),
                  offset: Offset(20, 20),
                ),
                BoxShadow(
                  color: Color(0xFFadb6ff),
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        weatherData.cityName,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        formats.floatin(weatherData.temp),
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        weatherData.description,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
