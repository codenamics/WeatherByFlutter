import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/common/format.dart';
import 'package:weather/providers/ForcastWeatherProvider.dart';

class ForcastWeatherUI extends StatelessWidget {
  const ForcastWeatherUI({
    @required this.formats,
  });

  final Formats formats;

  @override
  Widget build(BuildContext context) {
    var forcastData =
        Provider.of<ForcastWeatherProvider>(context).forcastWeatherData;
    return forcastData == null
        ? CircularProgressIndicator()
        : Container(
            margin: EdgeInsets.fromLTRB(12, 10, 12, 0),
            decoration: new BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: forcastData.length,
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
                              formats.readTimeStamp(forcastData[index].dt),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              forcastData[index].weather.main,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              formats.floatin(forcastData[index].main.temp),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ));
                }),
          );
  }
}
