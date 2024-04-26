import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_car/global/global_var.dart';
import 'package:go_car/pages/functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import '../data/models/place_suggestation.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late FloatingSearchBarController floatingSearchController;
  final Completer<GoogleMapController> _googleMapControllerCompleter =
      Completer();
  TextEditingController textEditingController = TextEditingController();
  final Set<Marker> _markers = {};
  Position? _currentPosition;
  List<PlaceSuggestion> suggestions = [];
  LatLng defaultPosition = const LatLng(26.8206, 30.8025);

  @override
  void initState() {
    super.initState();
    floatingSearchController = FloatingSearchBarController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    floatingSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          GooglePlaceAutoCompleteTextField(
            textEditingController: textEditingController,
            googleAPIKey: "AIzaSyCnf5vmISVW0pB3XbiyM9wsACG85GuyIqI",
            inputDecoration: const InputDecoration(),
            debounceTime: 800,
            countries: const ["in", "en", "us"],
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              print("placeDetails${prediction.lng}");
            },
            itemClick: (Prediction prediction) {
              textEditingController.text = prediction.description!;
              textEditingController.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length),
              );
            },
            // if we want to make custom list item builder
            itemBuilder: (context, index, Prediction prediction) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(child: Text(prediction.description ?? ""))
                  ],
                ),
              );
            },
            seperatedBuilder: const Divider(),
            isCrossBtnShown: true,
            containerHorizontalPadding: 10,
          ),
          _currentPosition != null
              ? Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) =>
                        _googleMapControllerCompleter.complete(controller),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 13,
                    ),
                    markers: _markers,
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

  void _getCurrentLocation() async {
    _currentPosition = await LocationHandler.getCurrentPosition();
    if (_currentPosition != null) {
      final currentLatLng = LatLng(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: currentLatLng,
        ),
      );
      setState(() {});
    }
  }
}