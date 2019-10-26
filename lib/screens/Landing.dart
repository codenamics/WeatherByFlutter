import 'package:flutter/material.dart';
import 'package:weather/screens/LocationCity.dart';
import 'package:weather/screens/AppBackgroud.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Center(
            child: LocationCity(),
          )
        ],
      ),
    );
  }
}
