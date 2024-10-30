import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WaterSourceMap extends StatefulWidget {
  const WaterSourceMap({super.key});

  @override
  _WaterSourceMapState createState() => _WaterSourceMapState();
}

class _WaterSourceMapState extends State<WaterSourceMap> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  // Sample data for water sources
  final List<LatLng> _waterSources = [
    LatLng(4.2105, 101.9758), // Example coordinates (replace with actual)
    LatLng(4.2155, 101.9778), // Example coordinates (replace with actual)
    // Add more coordinates here...
  ];

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    for (int i = 0; i < _waterSources.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('source_$i'),
          position: _waterSources[i],
          infoWindow: InfoWindow(
            title: 'Water Source ${i + 1}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Set border radius
        border: Border.all(
          color: Colors.blue, // Set border color
          width: 5, // Set border width
        ),
      ),
      height: 190, // Set the height of the map
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(4.2105, 101.9758), // Initial position of the map
          zoom: 10,
        ),
        markers: _markers,
      ),
    );
  }
}
