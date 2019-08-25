import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.text});

  String text;
  String apiKey = '4e2b39896dcc3622534cc498191bdc35';

  Future<dynamic> getData(text) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$text&appid=$apiKey&units=metric');

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getForcast(text) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?q=${text}&units=metric&appid=$apiKey');
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      print(response.statusCode);
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

  Future<dynamic> getForcastLocation(lat, lon) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey');
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
