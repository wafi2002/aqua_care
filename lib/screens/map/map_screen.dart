import 'dart:math';
import 'package:aqua_care/screens/map/widgets/water_source_map.dart';
import 'package:aqua_care/screens/map/widgets/water_source_table.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng? _currentPosition;
  LatLng? _selectedSource;
  Set<Polyline> _polylines = {};

  // List of water source's coordinates
  final List<LatLng> waterSources = [
    const LatLng(3.834870, 103.336563),
    const LatLng(4.602568, 101.075843),
  ];

  // List of water source
  final List<String> waterSourceNames = [
    'Pengurusan Air Pahang Berhad',
    'Lembaga Air Perak',
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData currentLocation = await location.getLocation();
      setState(() {
        _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    if (_currentPosition != null) {
      _controller!.moveCamera(CameraUpdate.newLatLng(_currentPosition!));
    }
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = waterSources.asMap().map((index, source) {
      return MapEntry(
        index,
        Marker(
          markerId: MarkerId(source.toString()),
          position: source,
          infoWindow: InfoWindow(title: waterSourceNames[index]),
          onTap: () {
            setState(() {
              _selectedSource = source;
              _fetchRoute(_currentPosition!, source);
            });
          },
        ),
      );
    }).values.toSet();

    if (_currentPosition != null) {
      markers.add(Marker(
        markerId: const MarkerId("user_location"),
        position: _currentPosition!,
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }

    return markers;
  }

  Future<void> _fetchRoute(LatLng origin, LatLng destination) async {
    String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _createPolylines(data);
      _zoomOutAndFocus(destination);
    } else {
      print('Failed to load directions: ${response.statusCode}');
    }
  }

  void _createPolylines(dynamic data) {
    if (data['routes'].isNotEmpty) {
      final List<LatLng> polylineCoordinates = [];
      for (var step in data['routes'][0]['legs'][0]['steps']) {
        LatLng point = LatLng(
          step['end_location']['lat'],
          step['end_location']['lng'],
        );
        polylineCoordinates.add(point);
      }

      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          visible: true,
          points: polylineCoordinates,
          width: 4,
          color: Colors.blue,
        ));
      });
    }
  }

  void _zoomOutAndFocus(LatLng destination) {
    if (_currentPosition != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          min(_currentPosition!.latitude, destination.latitude),
          min(_currentPosition!.longitude, destination.longitude),
        ),
        northeast: LatLng(
          max(_currentPosition!.latitude, destination.latitude),
          max(_currentPosition!.longitude, destination.longitude),
        ),
      );

      _controller?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(
              Icons.water_drop,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'Water Sources',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height, // Ensures it covers full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent.shade100, Colors.blueAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: WaterSourceMap(
                currentPosition: _currentPosition,
                onMapCreated: _onMapCreated,
                markers: _createMarkers(),
                polylines: _polylines,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: WaterSourceTable(
                  waterSourceNames: waterSourceNames,
                  waterSources: waterSources,
                  currentPosition: _currentPosition,
                  onSelectSource: (LatLng selectedSource) {
                    setState(() {
                      _selectedSource = selectedSource;
                      _fetchRoute(_currentPosition!, selectedSource);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
