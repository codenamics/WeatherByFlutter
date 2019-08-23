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
  dynamic newData;
  @override
  void initState() {
    super.initState();
    buildUI(widget.text);
  }

  buildUI(String text) async {
    var weatherData = await networkHelper.getData(text);
    var forecastData = await networkHelper.getForcast(text);
    print(forecastData['list'].toList());
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    description = weatherData['weather'][0]['description'];
    newData = forecastData['list'].toList();
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
              margin: EdgeInsets.fromLTRB(30, 1, 30, 0),
              decoration: new BoxDecoration(
                color: Color(0xff4556FE),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 40.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(
                      5.0, // horizontal, move right 10
                      5.0, // vertical, move down 10
                    ),
                  )
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
              margin: EdgeInsets.fromLTRB(20, 10, 30, 20),
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
              child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: newData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.all(5.0),
                        height: 50,
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                newData[index]['dt_txt'].toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                newData[index]['weather'][0]['main'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                newData[index]['main']['temp'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
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
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black)),
        elevation: 0,
        backgroundColor: Color(0xFFfafafa),
        title: const Text(
          'Change location',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
            child: Center(child: _pageToDisplay),
          )
        ],
      ),
    );
  }
}
