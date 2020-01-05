import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/CurrentWeather.dart';
import 'package:weather/common/format.dart';

class CurrentWeatherUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    double _calcFontSizeCity() {
      if (height == 896 || height == 667) {
        return 42;
      }
      return 14;
    }

    double _calcFontSizeCon() {
      if (height == 896 || height == 667) {
        return 22;
      }
      return 14;
    }

    print(height);
    Formats formats = Formats();
    var weatherData = Provider.of<CurrentWeatherProvider>(context).currentData;
    return SliverAppBar(
        forceElevated: true,
        backgroundColor: Colors.transparent,
        expandedHeight: MediaQuery.of(context).size.height * 0.5,
        flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/207130/pexels-photo-207130.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
                  fit: BoxFit.cover),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            weatherData.cityName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: _calcFontSizeCity(),
                                color: Colors.white),
                          ),
                          FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              weatherData.description,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: _calcFontSizeCon(),
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  width: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          formats.floatin(weatherData.temp),
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
