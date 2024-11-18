import 'package:flutter/material.dart';
import 'package:aqua_care/models/purification_method.dart';
import 'package:aqua_care/screens/purify/purification_detail_screen.dart';
import 'package:aqua_care/screens/purify/purification_categories_screen.dart';
import 'package:aqua_care/screens/sanitation/category_selection_screen.dart';
import 'package:aqua_care/screens/water_quality_api/quality_water.dart';
import 'package:aqua_care/base/widgets/app_double_text.dart';
import 'package:aqua_care/screens/map/widgets/water_source_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationData? _currentLocation;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  late GoogleMapController _mapController;

  // Predefined coordinates for specific locations
  final List<Map<String, dynamic>> _locations = [
    {
      'name': 'Langat Water Treatment Plant',
      'coordinates': LatLng(2.9570, 101.7900),
    },
    {
      'name': 'Papan Sewage Treatment Plant',
      'coordinates': LatLng(4.5333, 101.0833),
    },
    {
      'name': 'Sungai Perak Water Treatment Plant',
      'coordinates': LatLng(4.7500, 100.9333),
    },
    {
      'name': 'Sungai Langat Water Treatment Plant',
      'coordinates': LatLng(2.9570, 101.7900),
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    Location location = Location();

    // Check if location services are enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Check for location permissions
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Get current location
    final currentLocation = await location.getLocation();
    setState(() {
      _currentLocation = currentLocation;
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          infoWindow: const InfoWindow(title: "Your Location"),
        ),
      );
    });
  }

  void _initializeMarkers() {
    for (var location in _locations) {
      _markers.add(
        Marker(
          markerId: MarkerId(location['name']),
          position: location['coordinates'],
          infoWindow: InfoWindow(title: location['name']),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            // Greeting and App Info Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Good morning!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold, // Makes the text bold
                        color: Colors.white, // Sets the text color to white
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Half of the height/width for circular image
                      child: Image.asset(
                        'assets/images/aqua care.jpg', // Path to your image
                        height: 50, // Adjust the size as needed
                        width: 50,
                        fit: BoxFit.cover, // Ensures the image covers the given dimensions
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Text(
                  'Welcome to Aqua Care',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, // Makes the text bold
                    color: Colors.white, // Sets the text color to white
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Discover ways to purify water and learn the importance of sanitation.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[300]), // Adjusted for contrast
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Cards for Sanitation Quiz and Water Quality Info
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategorySelectionScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Icons.quiz, size: 50, color: Colors.blueAccent),
                            const SizedBox(height: 10),
                            const Text(
                              "Sanitation Quiz",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Test your knowledge about sanitation practices.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WaterDataScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Icons.water_drop, size: 50, color: Colors.teal),
                            const SizedBox(height: 10),
                            const Text(
                              "Water Quality Info",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Get real-time updates on water quality data.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Purification Methods Section Header
            AppDoubleText(
              bigText: 'Purification Methods',
              smallText: 'See all',
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PurificationCategoriesScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            // Horizontal ListView for Purification Methods
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: purificationMethods.length,
                itemBuilder: (context, index) {
                  final method = purificationMethods[index];
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          method.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PurificationDetailScreen(method: method),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.blue
                            ),
                            child: const Text('More'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Water Source Map Section
            Text(
              'Nearby Water Sources',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300, // Adjust height as needed
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: _currentLocation != null
                    ? CameraPosition(
                  target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                  zoom: 12,
                )
                    : const CameraPosition(
                  target: LatLng(37.7749, -122.4194), // Default to San Francisco
                  zoom: 12,
                ),
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
