import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  String? locationText;

  Future<void> _getCurrentLocation() async {
    bool isPermissionEnabled = await _checkPermission();

    if (!isPermissionEnabled) {
      isPermissionEnabled = await _requestPermission();
      if (!isPermissionEnabled) {
        print("Permission denied. Opening settings...");
        await Geolocator.openLocationSettings();
        return; // Exit function to prevent recursion
      }
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        locationText = "Lat: ${position.latitude}, Lng: ${position.longitude}";
      });

      print("Location updated: $locationText");
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<bool> _checkPermission() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    return locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse;
  }

  Future<bool> _requestPermission() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    return locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Location Data: $locationText"),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
