import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
final GOOGLE_API_KEY = dotenv.env['key'];

class LocationUtil {
  static String generateLocationPreviewImage({
    required double lat,
    required double long,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=12&size=400x400&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
