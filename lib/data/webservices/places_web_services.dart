import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

import '../../global/global_var.dart';

class PlacesWebservices {
  late Dio _dio;

  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    );
    _dio = Dio(options);
  }

  // Future<List<dynamic>> fetchSuggestions(
  //     String place, String sessionToken) async {
  //   try {
  //     Response response = await dio.get(
  //       suggestionsBaseUrl,
  //
  //       queryParameters: {
  //         'input': place,
  //         'types': 'address',
  //         'components': 'country:eg',
  //         'key': googleMapKey,
  //         'inputtype': 'textquery',
  //         // 'sessiontoken': sessionToken
  //       },
  //     );
  //     print(response.data['predictions']);
  //     debugPrint(response.statusCode.toString());
  //     return response.data['predictions'];
  //   } catch (error) {
  //     debugPrint(error.toString());
  //     return [];
  //   }
  // }
  Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken) async {
    final Map<String, dynamic> queryParams = {
      'input': place,
      'types': 'address',
      'key': googleMapKey,
      'inputtype': 'textquery',
      'sessiontoken': sessionToken,
    };

    try {
      final Response response =
          await _dio.get(suggestionsBaseUrl, queryParameters: queryParams);
      debugPrint('Status Code: ${response.statusCode}');
      return response.data['predictions'] as List<dynamic>;
    } on DioException catch (dioError) {
      debugPrint('DioError: ${dioError.message}');
      return [];
    } catch (error) {
      debugPrint('General Error: $error');
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      final Response response = await _dio.get(
        placeLocationBaseUrl,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': googleMapKey,
          'sessiontoken': sessionToken
        },
      );
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }

// origin equals current location
// destination equals searched for location

  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await _dio.get(
        directionsBaseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleMapKey,
        },
      );
      debugPrint("Omar I'm testing directions");
      debugPrint(response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
}
