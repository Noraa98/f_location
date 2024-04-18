import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import 'functions.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  //controller omar ahmed
  FloatingSearchBarController controller = FloatingSearchBarController();

  //


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





  // new part form omar ahmed

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
        controller: controller,
        elevation: 6,
        hintStyle: TextStyle(fontSize: 18),
        queryStyle: TextStyle(fontSize: 18),
        hint: 'Find a place..',
        border: BorderSide(style: BorderStyle.none),
        margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
        height: 52,
        iconColor: MyColors.blue,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 600),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        // progress: progressIndicator,
        onQueryChanged: (query) {
          // getPlacesSuggestions(query);
        },
        onFocusChanged: (_) {
          // hide distance and time row
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
                icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
                onPressed: () {}),
          ),
        ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // buildSuggestionsBloc(),
              // buildSelectedPlaceLocationBloc(),
              // buildDiretionsBloc(),
            ],
          ),
        );
      },
    );
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
