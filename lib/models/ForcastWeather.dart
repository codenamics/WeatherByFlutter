class ForcastWeather {
  int id;
  String main;
  String description;
  String icon;

  ForcastWeather({this.id, this.main, this.description, this.icon});

  factory ForcastWeather.fromJson(Map<String, dynamic> json) {
    return ForcastWeather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }
}
