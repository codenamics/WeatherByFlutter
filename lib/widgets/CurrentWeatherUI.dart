import 'package:flutter/material.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/common/format.dart';

class CurrentWeatherUI extends StatelessWidget {
  const CurrentWeatherUI({
    Key key,
    @required weatherData,
    @required this.formats,
    this.text,
    this.lat,
    this.lon,
  })  : _weatherData = weatherData,
        super(key: key);

  final _weatherData;
  final Formats formats;
  final text;
  final lat;
  final lon;

  @override
  Widget build(BuildContext context) {
    print(this.text);
    print(this.lon);
    print(this.lat);
    return Container(
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
                  _weatherData.cityName,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  formats.floatin(_weatherData.temp),
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
                  _weatherData.description,
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
