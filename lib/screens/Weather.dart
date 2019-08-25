import 'package:flutter/material.dart';
import 'package:weather/common/format.dart';

import 'package:weather/service/Network.dart';
import 'package:weather/service/location.dart';

class Weather extends StatefulWidget {
  Weather({this.text});
  final String text;

  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  NetworkHelper networkHelper = NetworkHelper();
  Location location = Location();
  Formats formats = Formats();
  int temperature;
  String cityName;
  String description;
  bool isLoading = true;
  dynamic newData;
  String city;
  @override
  void initState() {
    super.initState();
    city = widget.text;
    buildUI(city);
  }

  buildUI(String text) async {
    var weatherData = await networkHelper.getData(text);
    var forecastData = await networkHelper.getForcast(text);
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    description = weatherData['weather'][0]['description'];
    newData = forecastData['list'].toList();
    setState(() {
      isLoading = false;
    });
  }

  buildUIByLocation() async {
    await location.getCurrentLocation();
    var weatherLocation = await networkHelper.getDataLocation(
        location.latitude, location.longitude);
    var forcastLocation = await networkHelper.getForcastLocation(
        location.latitude, location.longitude);
    double temp = weatherLocation['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherLocation['name'];
    description = weatherLocation['weather'][0]['description'];
    newData = forcastLocation['list'].toList();
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
    return SafeArea(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(12, 1, 30, 0),
              decoration: new BoxDecoration(
                color: Color(0xff4556FE),
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
                          '$cityName',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '$temperature°C',
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
                          '$description',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.fromLTRB(12, 10, 12, 0),
              decoration: new BoxDecoration(
                color: Color(0xff4556FE),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: newData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.all(4.0),
                        height: 50,
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                formats.readTimeStamp(newData[index]['dt']),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                newData[index]['weather'][0]['main'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                formats.floatin(newData[index]['main']['temp']),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ));
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
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            icon: Icon(Icons.autorenew, color: Colors.black, size: 30),
            onPressed: () {
              if (city == "") {
                setState(() {
                  isLoading = true;
                  buildUIByLocation();
                });
              } else {
                setState(() {
                  isLoading = true;
                  buildUI(city);
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
                city = '';
                isLoading = true;
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
