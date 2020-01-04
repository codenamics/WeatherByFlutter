import 'package:geolocator/geolocator.dart';

class Location {
 
 static double latitude;
 static double longitude;

 static Future getCurrentLocation() async {
    try {
      
      GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
      print(geolocationStatus);
      if(geolocationStatus == GeolocationStatus.unknown || geolocationStatus == GeolocationStatus.denied){
        throw 'Access denied';
      }
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position.latitude);
    } catch (e) {
      throw e;
    }
  }
}
