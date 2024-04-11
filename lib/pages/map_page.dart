import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'functions.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? _currentPosition;
  LatLng? _currentLatLng;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getLocation() async {
    _currentPosition = await LocationHandler.getCurrentPosition();
    _currentLatLng =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentLatLng!,
      ),
    );
    setState(() {});
  }

  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLatLng!,
                zoom: 14.0,
              ),
              markers: markers,
            ),
    );
  }
}
