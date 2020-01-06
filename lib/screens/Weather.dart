import 'package:flutter/material.dart';
import 'package:weather/common/format.dart';
import 'package:weather/service/WeatherService.dart';
import 'package:weather/widgets/CurrentWeatherUI.dart';
import 'package:weather/widgets/ForcastWeatherUI.dart';

class Weather extends StatefulWidget {
  static const routeName = '/main-tasks-screen';
  final String text;

  Weather(this.text);
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool _isLoading = false;
  Formats formats = Formats();

  Future _refresh() async {
    setState(() {
      _isLoading = true;
    });
   await weatherByCityName(context, widget.text);
    print('city');
    setState(() {
      _isLoading = false;
    });
  }

  Future _refreshByLocation() async {
    setState(() {
      _isLoading = true;
    });
   await weatherByLocation(context);
    print('loc');
    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    print(widget.text);
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          size: 30,
                        ),
                      ),
                      actions: <Widget>[
                        widget.text != null
                            ? InkWell(
                                onTap: _refresh,
                                child: Icon(
                                  Icons.refresh,
                                  size: 40,
                                ),
                              )
                            : InkWell(
                                onTap: _refreshByLocation,
                                child: Icon(
                                  Icons.refresh,
                                  size: 30,
                                ),
                              ),
                        SizedBox(
                          width: 15,
                        )
                      ],
                      forceElevated: true,
                      expandedHeight: 220,
                      flexibleSpace: FlexibleSpaceBar(
                        background: CurrentWeatherUI(),
                      ),
                    ),
                  ];
                },
                body: ForcastWeatherUI()));
  }
}
