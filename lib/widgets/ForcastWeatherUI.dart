import 'package:flutter/material.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/common/format.dart';

class ForcastWeatherUI extends StatelessWidget {
  const ForcastWeatherUI({
    Key key,
    @required forcastData,
    @required this.formats,
  })  : _forcastData = forcastData,
        super(key: key);

  final _forcastData;
  final Formats formats;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 10, 12, 0),
      decoration: new BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _forcastData.length,
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
                        formats.readTimeStamp(_forcastData[index].dt),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        _forcastData[index].weather.main,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        formats.floatin(_forcastData[index].main.temp),
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
