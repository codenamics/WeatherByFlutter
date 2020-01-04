import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/CurrentWeather.dart';
import 'package:weather/providers/ForcastWeatherProvider.dart';


import 'package:weather/screens/Landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        ChangeNotifierProvider.value(
          value: CurrentWeatherProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ForcastWeatherProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        home: LandingPage(),
      ),
    );
  }
}
