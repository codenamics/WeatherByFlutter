class CurrentWeather {
  String cityName;
  double temp;
  String description;

  CurrentWeather({this.cityName, this.description, this.temp});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
        cityName: json['name'] as String,
        description: json['weather'][0]['description'] as String,
        temp: json['main']['temp'].toDouble());
  }
}
