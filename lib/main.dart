import 'package:flutter/material.dart';

import 'package:weather/screens/Landing.dart';
import 'package:weather/screens/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: LandingPage(),
    );
  }
}
