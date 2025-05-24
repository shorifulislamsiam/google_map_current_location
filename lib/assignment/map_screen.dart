import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/assignment/get_current_location_function.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  GetCurrentLocation _getCurrentLocation = GetCurrentLocation();
  bool _isProgress = false;

  Set<Marker> _marker = {};
  Set<Polyline> _polyLines = {};
  List<LatLng> _location= [];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //     _getCurrentLocation.getCurrentLocation();
  //     _startLocationUpdates();
  //     //setState(() {});
  //   super.initState();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _isProgress == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            zoom: 14,
            target: LatLng(23.776254487890746, 90.42489888791732),
          ),
          markers: _marker,
          polylines: _polyLines,
          onMapCreated: (controller) {
            _mapController = controller;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        onPressed: () async {
          //await _getCurrentLocation.getCurrentLocation();

          setState(() {
            _getCurrentLocation.getCurrentLocation();
            _mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 13, // Adjust zoom dynamically
                  target: LatLng(
                    _getCurrentLocation.latPos ?? 23.776254487890746,
                    _getCurrentLocation.lngPos ?? 90.42489888791732,
                  ),
                ),
              ),
            );
            _startLocationUpdates();
          });
        },
        child: Icon(Icons.location_on_outlined, color: Colors.red),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }




void _startLocationUpdates() {
    _location.clear();
    Timer.periodic(Duration(seconds: 10), (timer) async {

      await _getCurrentLocation.getCurrentLocation();
      setState(() {
        LatLng currentLatLng = LatLng(
          _getCurrentLocation.latPos ?? 23.776254487890746,
          _getCurrentLocation.lngPos ?? 90.42489888791732,
        );
        _UpdatePolyLine(currentLatLng);
       // _getCurrentLocation.getCurrentLocation();
        _marker = {
          Marker(
            markerId: MarkerId("My location"),
            position: LatLng(
              _getCurrentLocation.latPos ?? 23.776254487890746,
              _getCurrentLocation.lngPos ?? 90.42489888791732,
            ),
            infoWindow: InfoWindow(
              title: "My current location",
              snippet:
                  "${_getCurrentLocation.latPos ?? 23.776254487890746},${_getCurrentLocation.lngPos ?? 90.42489888791732}",
            ),
          ),
        };
      });
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 16, // Adjust zoom dynamically
            target: LatLng(
              _getCurrentLocation.latPos ?? 23.776254487890746,
              _getCurrentLocation.lngPos ?? 90.42489888791732,
            ),
          ),
        ),
      );
    });
    // print(_getCurrentLocation.latPos!);
    // print(_getCurrentLocation.lngPos!);
  }

  void _UpdatePolyLine(LatLng currentLatLng){
    setState(() {
      _location.add(currentLatLng);
      _polyLines={
        Polyline(
          polylineId: PolylineId("tracking"),
          points: _location,
          color: Colors.blue,
          width: 5,
        )
      };
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _mapController?.dispose();
    super.dispose();
  }
}
