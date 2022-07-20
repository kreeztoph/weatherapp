import 'package:geolocator/geolocator.dart';

<<<<<<< HEAD
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
=======
abstract class LocationInfo {
  Future<Position> get isLocationGranted;
}

class Locationimpl implements LocationInfo {
  Position? _position;
  Locationimpl(this._position);

  Future<Position> determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    _position = position;
    print(_position);
  }

  @override
  Future<Position> get isLocationGranted => determinePosition();
>>>>>>> 97e521aeef61a9ebd3ddc8b1cff5392bbc697d77
}
