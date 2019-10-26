import 'package:http/http.dart' as http;
import 'package:weather/models/CurrentWeather.dart';
import 'dart:convert';

import 'package:weather/models/Forcast.dart';

class ForcastService {
  ForcastService({this.text});
  CurrentWeather currentWeather = CurrentWeather();
  String text;
  String apiKey = '4e2b39896dcc3622534cc498191bdc35';

  Future<List<Forcast>> getForcast(text) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?q=$text&units=metric&appid=$apiKey');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      final forcast =
          (data['list'] as List).map((i) => new Forcast.fromJson(i));
      return forcast.toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getForcastLocation(lat, lon) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      final forcast =
          (data['list'] as List).map((i) => new Forcast.fromJson(i));
      return forcast.toList();
    } else {
      return [];
    }
  }
}
