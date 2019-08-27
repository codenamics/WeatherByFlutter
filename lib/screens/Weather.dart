import 'package:flutter/material.dart';
import 'package:weather/common/format.dart';

import 'package:weather/service/WeatherService.dart';
import 'package:weather/service/ForcastService.dart';
import 'package:weather/service/Location.dart';
import 'package:weather/widgets/CurrentWeatherUI.dart';
import 'package:weather/widgets/ForcastWeatherUI.dart';

class Weather extends StatefulWidget {
  Weather({this.text});
  final String text;

  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherService weatherService = WeatherService();
  ForcastService forcastService = ForcastService();
  Location location = Location();
  Formats formats = Formats();
  int temperature;
  String cityName;
  String description;
  bool _isLoading = true;
  dynamic _weatherData;
  dynamic _forcastData;
  String _city;
  @override
  void initState() {
    super.initState();
    _city = widget.text;
    buildUI(_city);
  }

  buildUI(String text) async {
    _weatherData = await weatherService.getData(text);
    _forcastData = await forcastService.getForcast(text);

    setState(() {
      _isLoading = false;
    });
  }

  buildUIByLocation() async {
    await location.getCurrentLocation();
    var weatherLocation = await weatherService.getDataLocation(
        location.latitude, location.longitude);
    var forcastLocation = await forcastService.getForcastLocation(
        location.latitude, location.longitude);
    double temp = weatherLocation['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherLocation['name'];
    description = weatherLocation['weather'][0]['description'];
    _forcastData = forcastLocation['list'].toList();
    setState(() {
      _isLoading = false;
    });
  }

  Widget get _pageToDisplay {
    if (_isLoading == true) {
      return _loadingView;
    } else {
      return _weatherView;
    }
  }

  Widget get _loadingView {
    return Center(child: CircularProgressIndicator());
  }

  Widget get _weatherView {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child:
                CurrentWeatherUI(weatherData: _weatherData, formats: formats),
          ),
          SizedBox(
            height: 30,
          ),
          Flexible(
            flex: 2,
            child:
                ForcastWeatherUI(forcastData: _forcastData, formats: formats),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            icon: Icon(Icons.autorenew, color: Colors.black, size: 30),
            onPressed: () {
              if (_city == "") {
                setState(() {
                  _isLoading = true;
                  buildUIByLocation();
                });
              } else {
                setState(() {
                  _isLoading = true;
                  buildUI(_city);
                });
              }
            },
          ),
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () async {
              setState(() {
                _city = '';
                _isLoading = true;
              });
              await buildUIByLocation();
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Change location',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFFfafafa)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: Center(child: _pageToDisplay),
            ),
          )
        ],
      ),
    );
  }
}
