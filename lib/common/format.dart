import 'package:intl/intl.dart';

class Formats {
  double temp;
  int timestamp;
  Formats({this.temp, this.timestamp});

  String readTimeStamp(timestamp) {
    final dateFormat = DateFormat('dd/MM/yyyy  | ');
    return dateFormat
        .add_Hm()
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000))
        .toString();
  }

  String floatin(temp) {
    var rounded = temp.round().toString();
    var temperature = rounded + '°C';
    return temperature;
  }
}
