import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(23.772492945985334, 90.42523657369168),
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        onTap: (LatLng latlang) {
          print(latlang);
        },
        markers: {
          Marker(
            markerId: MarkerId("My Location"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            position: LatLng(23.772492945985334, 90.42523657369168),
            infoWindow: InfoWindow(title: "my location"),
            onTap: () {
              print("my location");
            },
          ),
          Marker(
            markerId: MarkerId("Marker2 location"),
            draggable: true,
            infoWindow: InfoWindow(title: "Location"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            position: LatLng(23.77979070988387, 90.42473617941141),
            onDrag: (LatLng dratLatlan) {
              //print(dratLatlan);
            },
            onDragStart: (LatLng stLatLng) {
              print(stLatLng);
            },
            onDragEnd: (LatLng endLatLng) {
              print(endLatLng);
            },
          ),
        },
        circles: {
          Circle(
            circleId: CircleId("Circle id"),
            center: LatLng(23.7699637691025, 90.41899021714926),
            radius: 250,
            strokeColor: Colors.green,
            fillColor: Colors.red.withOpacity(0.2),
            strokeWidth: 2,
          ),
        },
        polygons: {
          Polygon(
            polygonId: PolygonId("Polygon Id"),
            fillColor: Colors.green.withOpacity(0.25),
            strokeWidth: 1,
            points: [
              LatLng(23.765306236974006, 90.41904252022505),
              LatLng(23.765920541223498, 90.42264707386494),
              LatLng(23.761278820851533, 90.4245350137353),
              LatLng(23.75915014683762, 90.42085234075785),
              LatLng(23.761492698959557, 90.41564047336578),
            ],
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _mapController.moveCamera(
          //   CameraUpdate.newCameraPosition(
          //     CameraPosition(
          //       zoom: 17,
          //       target: LatLng(23.785268413034846, 90.41732959449291),
          //     ),
          //   ),
          // );
          _mapController.animateCamera(
            //duration: Duration(seconds: 3),
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 17,
                target: LatLng(23.785268413034846, 90.41732959449291),
              ),
            ),
          );
        },
        child: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mapController.dispose();
    super.dispose();
  }
}


//////////
//For gate the smooth current location with the marker accurately
// void _startLocationUpdates() {
//   Geolocator.getPositionStream(
//     locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
//   ).listen((Position position) {
//     setState(() {
//       _getCurrentLocation.latPos = position.latitude;
//       _getCurrentLocation.lngPos = position.longitude;
//
//       _marker = {
//         Marker(
//           markerId: MarkerId("My location"),
//           position: LatLng(_getCurrentLocation.latPos!, _getCurrentLocation.lngPos!),
//           infoWindow: InfoWindow(title: "My current location"),
//         ),
//       };
//     });
//
//     // Move camera smoothly to new location
//     _mapController?.animateCamera(
//       CameraUpdate.newLatLng(LatLng(_getCurrentLocation.latPos!, _getCurrentLocation.lngPos!)),
//     );
//   });
// }