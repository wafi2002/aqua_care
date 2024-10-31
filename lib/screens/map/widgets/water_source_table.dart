import 'dart:math';
import 'package:flutter/material.dart';
import 'water_source_details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WaterSourceTable extends StatelessWidget {
  final List<String> waterSourceNames;
  final List<LatLng> waterSources;
  final LatLng? currentPosition;
  final Function(LatLng) onSelectSource;

  // Added parameters for customizable styling and layout
  final double rowHeight;
  final double columnPadding;
  final TextStyle sourceTextStyle;
  final TextStyle distanceTextStyle;
  final Color actionButtonColor;

  const WaterSourceTable({
    super.key,
    required this.waterSourceNames,
    required this.waterSources,
    required this.currentPosition,
    required this.onSelectSource,
    this.rowHeight = 80, // Default row height
    this.columnPadding = 8, // Default column padding
    this.sourceTextStyle = const TextStyle(fontSize: 16),
    this.distanceTextStyle = const TextStyle(fontSize: 14, color: Colors.grey),
    this.actionButtonColor = Colors.blue, // Default action button color
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4, // Limit height to 40% of screen height
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header for Organization and Info
            Container(
              padding: EdgeInsets.symmetric(horizontal: columnPadding, vertical: 12), // Increased vertical padding
              decoration: const BoxDecoration(
                color: Colors.green, // Background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0), // Radius for the top left corner
                  topRight: Radius.circular(15.0), // Radius for the top right corner
                )
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Organization',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  // Info Header
                  Text(
                    'Info',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            // List of Water Sources
            Expanded(
              child: ListView.builder(
                itemCount: waterSourceNames.length,
                itemBuilder: (context, index) {
                  double distance = currentPosition != null
                      ? _calculateDistance(currentPosition!, waterSources[index])
                      : 0;

                  return Container(
                    height: rowHeight,
                    padding: EdgeInsets.symmetric(vertical: columnPadding, horizontal: columnPadding),
                    margin: const EdgeInsets.symmetric(vertical: 1), // Add some spacing between rows
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // Changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Source Name and Distance
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // When the row is tapped, call the onSelectSource function
                              onSelectSource(waterSources[index]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  waterSourceNames[index],
                                  style: sourceTextStyle,
                                  overflow: TextOverflow.ellipsis, // Prevent overflow
                                  maxLines: 1, // Limit to 1 line
                                ),
                                Text(
                                  'Distance: ${distance.toStringAsFixed(2)} km',
                                  style: distanceTextStyle,
                                  overflow: TextOverflow.ellipsis, // Prevent overflow
                                  maxLines: 1, // Limit to 1 line
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Action Button
                        IconButton(
                          icon: Icon(Icons.info, color: actionButtonColor, size: 30.0),
                          onPressed: () {
                            // Navigate to the details page for the selected water source
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WaterSourceDetails(sourceName: waterSourceNames[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers
    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLng = _degreesToRadians(end.longitude - start.longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) * cos(_degreesToRadians(end.latitude)) *
            sin(dLng / 2) * sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c; // Distance in kilometers

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }
}
