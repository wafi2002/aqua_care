import 'package:google_maps_flutter/google_maps_flutter.dart';

class WaterSource {
  final String name;
  final LatLng coordinates;

  WaterSource({required this.name, required this.coordinates});

  factory WaterSource.fromJson(Map<String, dynamic> json) {
    return WaterSource(
      name: json['name'],
      coordinates: LatLng(
        json['coordinates']['latitude'],
        json['coordinates']['longitude'],
      ),
    );
  }
}
