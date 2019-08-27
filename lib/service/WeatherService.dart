import 'package:http/http.dart' as http;
import 'package:weather/models/CurrentWeather.dart';
import 'dart:convert';

import 'package:weather/models/Forcast.dart';

class WeatherService {
  WeatherService({this.text});
  CurrentWeather currentWeather = CurrentWeather();
  String text;
  String apiKey = '4e2b39896dcc3622534cc498191bdc35';

  Future<dynamic> getData(text) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$text&appid=$apiKey&units=metric');

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      var dd = CurrentWeather.fromJson(data);
      return dd;
    } else {
      return [];
    }
  }

  Future<dynamic> getDataLocation(lat, lon) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
