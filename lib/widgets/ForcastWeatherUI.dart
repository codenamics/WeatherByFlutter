import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/common/format.dart';
import 'package:weather/providers/ForcastWeatherProvider.dart';

class ForcastWeatherUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Formats formats = Formats();
    var forcastData =
        Provider.of<ForcastWeatherProvider>(context).forcastWeatherData;
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black38,
            ),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        itemCount: forcastData.length,
        itemBuilder: (ctx, index) => Container(
            margin: const EdgeInsets.all(4.0),
            height: 50,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    formats.readTimeStamp(forcastData[index].dt),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    forcastData[index].weather.main,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    formats.floatin(forcastData[index].main.temp),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )));
  }
}
