import 'package:flutter/material.dart';
import 'package:google_map/assignment/map_screen.dart';
import 'package:google_map/ui/screen/MyHomePage.dart';
import 'package:google_map/ui/screen/current_location.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(),//CurrentLocation(),//MyHomePage(),
    );
  }
}
