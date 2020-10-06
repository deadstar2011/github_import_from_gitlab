import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Geolocation {
  static Geolocation _geo;
  Geolocator _locator;

  Geolocation.empty() {
    _locator = Geolocator()..forceAndroidLocationManager = true;
  }

  factory Geolocation() {
    _geo ??= Geolocation.empty();

    return _geo;
  }

  Future<bool> checkGeolocationStatusGranted() async {
    final status = await Permission.location.status;
    return status.isGranted;
  }

  Future<bool> checkGeolocationEnabled() async {
    return await _locator.isLocationServiceEnabled();
  }

  Future<bool> requestGeolocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<Position> getCurrentPosition() async {
    try {
      final isEnabled = await _locator.isLocationServiceEnabled();

      if (!isEnabled) {
        return null;
      }

      final position = await _locator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      return null;
    }
  }
}
