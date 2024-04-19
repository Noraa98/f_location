import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:go_car/global/global_var.dart';
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;

// import 'package:location/location.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
class SearchBarView extends StatefulWidget {
  const SearchBarView({super.key});

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  final Map<String, Marker> _markers = {};

  double latitude = 0;
  double longitude = 0;
  GoogleMapController? _controller;

  Future<void> _handleSearch() async {
    places.Prediction? p = await loc.PlacesAutocomplete.show(
      context: context,
      apiKey: googleMapKey,
      onError: onError,
      // call the onError function below
      mode: loc.Mode.overlay,
      language: 'en',
      //you can set any language for search
      strictbounds: false,
      types: [],
      decoration: InputDecoration(
        hintText: 'search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      components: [], // you can determine search for just one country
    );
    print(p!.toJson());
    displayPrediction(p);
  }

  void onError(places.PlacesAutocompleteResponse response) {
    debugPrint(response.errorMessage);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(response.errorMessage ?? ''),
      ),
    );
  }

  Future<void> displayPrediction(places.Prediction p) async {
    places.GoogleMapsPlaces place = places.GoogleMapsPlaces(
        apiKey: googleMapKey,
        apiHeaders: await const header.GoogleApiHeaders().getHeaders());
    places.PlacesDetailsResponse detail =
        await place.getDetailsByPlaceId(p.placeId!);
// detail will get place details that user chose from Prediction search
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    _markers.clear(); //clear old marker and set new one
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSearch,
          child: const Text('search'),
        ),
      ),
    );
  }
}
