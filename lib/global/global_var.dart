import 'package:google_maps_flutter/google_maps_flutter.dart';

String googleMapKey = "AIzaSyCnf5vmISVW0pB3XbiyM9wsACG85GuyIqI";
String suggestionsBaseUrl =
// 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    "https://maps.googleapis.com/maps/api/place/textsearch/output";
String placeLocationBaseUrl =
    'https://maps.googleapis.com/maps/api/place/details/json';
String directionsBaseUrl =
    'https://maps.googleapis.com/maps/api/directions/json';

const CameraPosition googlePlexInitialPosition =
    CameraPosition(target: LatLng(31, 41), zoom: 14.4746);