// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_map_position_control.dart';

const double initialGoogleMapZoomLevel = 19;
const LatLng homeSweetHome = LatLng(55.1623987, 61.4467306);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kChelyabinskLovina22 = CameraPosition(
    target: homeSweetHome,
    zoom: initialGoogleMapZoomLevel,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            initialCameraPosition: _kChelyabinskLovina22,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: GoogleMapPositionControl(
                controller: _controller,
                initialZoomLevel: initialGoogleMapZoomLevel,
                initialPosition: homeSweetHome,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
