import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class WaterSourceMap extends StatelessWidget {
  final LatLng? currentPosition;
  final Function(GoogleMapController) onMapCreated;
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  const WaterSourceMap({
    super.key,
    required this.currentPosition,
    required this.onMapCreated,
    required this.markers,
    required this.polylines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: currentPosition!,
          zoom: 14,
        ),
        markers: markers,
        polylines: polylines,
      ),
    );
  }
}
