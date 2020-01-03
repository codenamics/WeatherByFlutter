import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/common/format.dart';
import 'package:weather/providers/CurrentWeather.dart';
import 'package:weather/providers/ForcastWeatherProvider.dart';

import 'package:weather/widgets/CurrentWeatherUI.dart';
import 'package:weather/widgets/ForcastWeatherUI.dart';

import '../widgets/ForcastWeatherUI.dart';

class Weather extends StatefulWidget {
  Weather({this.text});
  final String text;
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Formats formats = Formats();

  String _city;

  @override
  void initState() {
    super.initState();
    _city = widget.text;
  }

  _refreshForcast() async {
    await Provider.of<ForcastWeatherProvider>(context, listen: false)
        .getForcast(_city);
  }

  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            icon: Icon(
              Icons.autorenew,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              await Provider.of<CurrentWeatherProvider>(context, listen: false)
                  .getDataLocation();
              await Provider.of<ForcastWeatherProvider>(context, listen: false)
                  .getForcastLocation();
            },
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Change location',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(
                0xFFfafafa,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: Center(
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: CurrentWeatherUI(
                          // lat: _lat,
                          // lon: _lon,
                          // text: _city,

                          formats: formats,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Flexible(
                        flex: 2,
                        child: RefreshIndicator(
                            onRefresh: () => _refreshForcast(),
                            child: ForcastWeatherUI(
                              formats: formats,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
