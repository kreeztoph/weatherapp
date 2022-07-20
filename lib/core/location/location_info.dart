import 'package:geolocator/geolocator.dart';

abstract class LocationInfo {
  Future<Position> get isLocationGranted;
}

class Locationimpl implements LocationInfo {
  // ignore: unused_field
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
  }

  @override
  Future<Position> get isLocationGranted => determinePosition();
}
