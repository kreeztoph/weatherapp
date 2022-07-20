import 'package:geolocator/geolocator.dart';

abstract class LocationInfo {}

class Locationimpl implements LocationInfo {
  Future<Position> getGeoLocationPosition() async {
    bool locationGranted;
    LocationPermission permission;

    locationGranted = await Geolocator.isLocationServiceEnabled();
    if (!locationGranted) {
      await Geolocator.openAppSettings();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request permission");
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
