// import 'package:flutter_maps/data/models/Place_suggestion.dart';
// import 'package:flutter_maps/data/models/place.dart';
// import 'package:flutter_maps/data/models/place_directions.dart';
// import 'package:flutter_maps/data/webservices/places_webservices.dart';
import 'package:latlong2/latlong.dart';

import '../models/place.dart';
import '../models/place_directions.dart';
import '../models/place_suggestation.dart';
import '../webservices/places_web_services.dart';

class MapsRepository {
  final PlacesWebservices placesWebservices;

  MapsRepository(this.placesWebservices);

  Future<List<PlaceSuggestion>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebservices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebservices.getPlaceLocation(placeId, sessionToken);
    // var readyPlace = Place.fromJson(place);
    return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final directions =
        await placesWebservices.getDirections(origin, destination);

    return PlaceDirections.fromJson(directions);
  }
}
