import 'package:provider/provider.dart';
import 'package:weather/providers/CurrentWeather.dart';
import 'package:weather/providers/ForcastWeatherProvider.dart';
import 'package:weather/service/LocationService.dart';

Future<void> weatherByCityName(context, text) async {
  await Provider.of<CurrentWeatherProvider>(context, listen: false)
      .getData(text);
  await Provider.of<ForcastWeatherProvider>(context, listen: false)
      .getForcast(text);
}

Future<void> weatherByLocation(context) async {
  await Location.getCurrentLocation();
  await Provider.of<CurrentWeatherProvider>(context, listen: false)
      .getDataLocation();
  await Provider.of<ForcastWeatherProvider>(context, listen: false)
      .getForcastLocation();
}
