class ForcastMain {
   final double temp;
 final double temp_min;
 final double temp_max;
 final double pressure;
 final double sea_level;
 final double grnd_level;
 final int humidity;
 final double temp_kf;

  ForcastMain(
      {this.temp,
      this.grnd_level,
      this.humidity,
      this.pressure,
      this.sea_level,
      this.temp_kf,
      this.temp_max,
      this.temp_min});

  factory ForcastMain.fromJson(Map<String, dynamic> json) {
    return ForcastMain(
        temp: json['temp'].toDouble() as double,
        temp_min: json['temp_min'].toDouble() as double,
        temp_max: json['temp_max'].toDouble() as double,
        pressure: json['pressure'].toDouble() as double,
        sea_level: json['sea_level'].toDouble() as double,
        grnd_level: json['grnd_level'].toDouble() as double,
        humidity: json['humidity'] as int,
        temp_kf: json['temp_kf'].toDouble() as double);
  }
}
