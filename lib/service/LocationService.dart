import 'package:geolocator/geolocator.dart';

class Location {
 
 static double latitude;
 static double longitude;

 static Future getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position.latitude);
    } catch (e) {
      print(e);
    }
  }
}
