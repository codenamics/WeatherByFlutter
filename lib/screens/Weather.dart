import 'package:flutter/material.dart';
import 'package:weather/screens/AppBackgroud.dart';
import 'package:weather/service/Network.dart';

class Weather extends StatefulWidget {
  Weather({this.text});
  final String text;
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  NetworkHelper networkHelper = NetworkHelper();
  int temperature;
  String cityName;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    buildUI(widget.text);
  }

  buildUI(String text) async {
    var weatherData = await networkHelper.getData(text);
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    setState(() {
      isLoading = false;
    });
  }

  Widget get _pageToDisplay {
    if (isLoading == true) {
      return _loadingView;
    } else {
      return _weatherView;
    }
  }

  Widget get _loadingView {
    return new Center(
      child: Text('loading'),
    );
  }

  Widget get _weatherView {
    return new Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$temperature°',
            style: TextStyle(fontSize: 79),
          ),
          Text(
            '$cityName',
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.transparent,
        title: const Text('Change location'),
      ),
      body: Stack(
        children: <Widget>[AppBackground(), Center(child: _pageToDisplay)],
      ),
    );
  }
}
