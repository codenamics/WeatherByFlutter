import 'package:flutter/material.dart';
import 'package:weather/screens/AppBackgroud.dart';
import 'package:weather/service/Network.dart';

class Weather extends StatefulWidget {
  Weather({this.text});
  final String text;

  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'C',
    'C',
    'C',
    'C',
    'C',
    'C',
    'C',
  ];
  final List<int> colorCodes = <int>[
    600,
    500,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
  ];
  NetworkHelper networkHelper = NetworkHelper();
  int temperature;
  String cityName;
  String description;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    buildUI(widget.text);
  }

  buildUI(String text) async {
    var weatherData = await networkHelper.getData(text);
    var forecastData = await networkHelper.getForcast(text);
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    description = weatherData['weather'][0]['description'];
    print(weatherData);
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
    return Center(child: CircularProgressIndicator());
  }

  Widget get _weatherView {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$cityName',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    '$temperature°C',
                    style: TextStyle(fontSize: 79),
                  ),
                  Text(
                    '$description',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
          Row(),
          SizedBox(
            height: 80.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8.0),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      color: Colors.amber[colorCodes[index]],
                      child: Center(child: Text('Entry ${entries[index]}')),
                    ),
                  );
                }),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 400.0,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.amber[colorCodes[index]],
                      child: Center(child: Text('Entry ${entries[index]}')),
                    );
                  }),
            ),
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
