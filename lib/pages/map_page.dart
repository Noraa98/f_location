// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
//
// // import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
//
// import '../data/repository/maps_repo.dart';
// import '../data/webservices/places_web_services.dart';
// import 'functions.dart';
//
// class MapPage extends StatefulWidget {
//   const MapPage({super.key});
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   //controller omar ahmed
//   FloatingSearchBarController controller = FloatingSearchBarController();
//   MapsRepository mapsRepository = MapsRepository(PlacesWebservices());
//   Position? _currentPosition;
//   LatLng? _currentLatLng;
//
//   @override
//   void initState() {
//     getLocation();
//
//     super.initState();
//   }
//
//   void getLocation() async {
//     _currentPosition = await LocationHandler.getCurrentPosition();
//     _currentLatLng =
//         LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
//     markers.add(
//       Marker(
//         markerId: const MarkerId('currentLocation'),
//         position: _currentLatLng!,
//       ),
//     );
//     setState(() {});
//   }
//
//   final Completer<GoogleMapController> googleMapCompleterController =
//       Completer<GoogleMapController>();
//   GoogleMapController? mapController;
//   Set<Marker> markers = {};
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   // // new part form omar ahmed
//   // Widget buildFloatingSearchBar() {
//   //   final bool isPortrait =
//   //       MediaQuery.of(context).orientation == Orientation.portrait;
//   //   return FloatingSearchBar(
//   //     controller: controller,
//   //     elevation: 6,
//   //     hintStyle: const TextStyle(fontSize: 18),
//   //     queryStyle: const TextStyle(fontSize: 18),
//   //     hint: 'Find a place..',
//   //     border: const BorderSide(style: BorderStyle.none),
//   //     margins: const EdgeInsets.fromLTRB(20, 70, 20, 0),
//   //     padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
//   //     height: 52,
//   //     iconColor: Colors.blue,
//   //     scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//   //     transitionDuration: const Duration(milliseconds: 600),
//   //     transitionCurve: Curves.easeInOut,
//   //     physics: const BouncingScrollPhysics(),
//   //     axisAlignment: isPortrait ? 0.0 : -1.0,
//   //     openAxisAlignment: 0.0,
//   //     width: isPortrait ? 600 : 500,
//   //     debounceDelay: const Duration(milliseconds: 500),
//   //     // progress: progressIndicator,
//   //     onQueryChanged: (query) {
//   //       // placesWebservices.fetchSuggestions(query, googleMapKey);
//   //       // getPlacesSuggestions(query);
//   //       mapsRepository.fetchSuggestions(query, googleMapKey);
//   //     },
//   //     onFocusChanged: (_) {
//   //       // hide distance and time row
//   //     },
//   //     // transition: CircularFloatingSearchBarTransition(),
//   //     actions: [
//   //       FloatingSearchBarAction(
//   //         showIfOpened: false,
//   //         child: CircularButton(
//   //           icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
//   //           onPressed: () {},
//   //         ),
//   //       ),
//   //     ],
//   //     builder: (context, transition) {
//   //       return ClipRRect(
//   //         borderRadius: BorderRadius.circular(8),
//   //         child: const Column(
//   //           mainAxisAlignment: MainAxisAlignment.start,
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: <Widget>[],
//   //           // children: [
//   //           //   // buildSuggestionsBloc(),
//   //           //   // buildSelectedPlaceLocationBloc(),
//   //           //   // buildDiretionsBloc(),
//   //           // ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   //   // return Container();
//   // }
//
//   Widget buildFloatingSearchBar() {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//
//     return FloatingSearchBar(
//       controller: controller,
//       elevation: 6,
//       hintStyle: const TextStyle(fontSize: 18),
//       queryStyle: const TextStyle(fontSize: 18),
//       hint: 'Find a place..',
//       border: _noBorder(),
//       margins: _searchBarMargins(),
//       padding: _searchBarPadding(),
//       height: 52,
//       iconColor: Colors.blue,
//       scrollPadding: _scrollPadding(),
//       transitionDuration: const Duration(milliseconds: 600),
//       transitionCurve: Curves.easeInOut,
//       physics: const BouncingScrollPhysics(),
//       axisAlignment: isPortrait ? 0.0 : -1.0,
//       openAxisAlignment: 0.0,
//       width: isPortrait ? 600 : 500,
//       debounceDelay: const Duration(milliseconds: 500),
//       onQueryChanged: (query) => _onQueryChanged(query),
//       actions: _floatingSearchBarActions(),
//       builder: (context, transition) => _searchBarBuilder(),
//     );
//   }
//
//   List<FloatingSearchBarAction> _floatingSearchBarActions() {
//     return [
//       FloatingSearchBarAction(
//         showIfOpened: false,
//         child: CircularButton(
//           icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
//           onPressed: () {},
//         ),
//       ),
//     ];
//   }
//
//   Widget _searchBarBuilder() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(8),
//       child: const Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : buildFloatingSearchBar(),
//     );
//   }
//
//   void _onQueryChanged(String query) {
//     String sessionToken = DateTime.now().millisecondsSinceEpoch.toString();
//     mapsRepository.fetchSuggestions(query, sessionToken);
//   }
//
//   BorderSide _noBorder() => const BorderSide(style: BorderStyle.none);
//
//   EdgeInsets _searchBarMargins() => const EdgeInsets.fromLTRB(20, 70, 20, 0);
//
//   EdgeInsets _searchBarPadding() => const EdgeInsets.fromLTRB(2, 0, 2, 0);
//
//   EdgeInsets _scrollPadding() => const EdgeInsets.only(top: 16, bottom: 56);
// }
// //GoogleMap(
// //                     onMapCreated: _onMapCreated,
// //                     initialCameraPosition: CameraPosition(
// //                       target: _currentLatLng!,
// //                       zoom: 14.0,
// //                     ),
// //                     markers: markers,
// //                   ),

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_car/pages/functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import '../data/models/place_suggestation.dart';
import '../data/repository/maps_repo.dart';
import '../data/webservices/places_web_services.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late FloatingSearchBarController _controller;
  late MapsRepository _mapsRepository;
  final Completer<GoogleMapController> _googleMapControllerCompleter =
      Completer();
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  Position? _currentPosition;
  List<PlaceSuggestion> suggestions = [];
  LatLng defaultPosition = const LatLng(26.8206, 30.8025);

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    _mapsRepository = MapsRepository(PlacesWebservices());
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _googleMapControllerCompleter.complete(controller);
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      controller: _controller,
      elevation: 6,
      hint: 'Find a place...',
      border: BorderSide.none,
      margins: const EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: Colors.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: _onQueryChanged,
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place, color: Colors.black54),
            onPressed: () {},
          ),
        ),
      ],
      builder: (context, transition) {
        if (suggestions.isEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Material(
              child: ListTile(
                title: Text('No suggestions found'),
              ),
            ),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return ListTile(
                  title: Text(suggestion.description),
                  onTap: () {
                    // Handle the tap event, maybe use the suggestion for a search or place details
                    debugPrint(
                        'Tapped on suggestion: ${suggestion.description}');
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _onQueryChanged(String query) async {
    String sessionToken = DateTime.now().millisecondsSinceEpoch.toString();
    suggestions = await _mapsRepository.fetchSuggestions(query, sessionToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildFloatingSearchBar(),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: (_currentPosition == null
                    ? defaultPosition
                    : LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      )),
                zoom: 13,
              ),
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
