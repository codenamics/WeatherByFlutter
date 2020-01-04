import 'package:geolocator/geolocator.dart';

class Location {
  static double latitude;
  static double longitude;

  static Future getCurrentLocation() async {
    try {
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();
print(geolocationStatus);
      if (geolocationStatus == GeolocationStatus.unknown || geolocationStatus == GeolocationStatus.granted) {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
      }
      if (
          geolocationStatus == GeolocationStatus.denied) {
        throw 'Access denied';
      }
    } catch (e) {
      throw e;
    }
  }
}
