import 'package:flutter/material.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/screens/Weather.dart';

class LocationCity extends StatelessWidget {
  String text;

  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text(
                    'WeatherApp',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
                  )),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffa3a3a3), width: 1),
                  ),
                  hintText: 'CityName',
                  prefixText: ' ',
                ),
                onChanged: (value) {
                  text = value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),
              FlatButton(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                color: buttonColor,
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Weather(
                          text: text,
                        ),
                      ));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Text(
                  'Get Weather',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
