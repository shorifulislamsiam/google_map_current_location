import 'dart:async';
import 'package:geolocator/geolocator.dart';


class GetCurrentLocation {
  String? positionLocation;
  double?  latPos = 23.776254487890746;
  double? lngPos = 90.42489888791732;

  Future<void> getCurrentLocation() async {
    bool isPermissionEnabled = await checkPermission();

    if (!isPermissionEnabled) {
      isPermissionEnabled = await requestPermission();
      if (!isPermissionEnabled) {
        print("Permission denied. Opening settings...");
        await Geolocator.openLocationSettings();
        return;
      }
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latPos = position.latitude;
      lngPos = position.longitude;
      positionLocation =
          "Lat: ${position.latitude}, Lng: ${position.longitude}";
      print("Location updated: $positionLocation");
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<bool> checkPermission() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    return locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse;
  }

  Future<bool> requestPermission() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    return locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse;
  }

}
