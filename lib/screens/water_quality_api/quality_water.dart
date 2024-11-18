import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class WaterDataScreen extends StatefulWidget {
  const WaterDataScreen({super.key});

  @override
  _WaterDataScreenState createState() => _WaterDataScreenState();
}

class _WaterDataScreenState extends State<WaterDataScreen> {
  Future<Map<String, dynamic>>? _waterData;

  @override
  void initState() {
    super.initState();
    // List of site codes for multiple locations
    List<String> siteCodes = ['01646500', '02037500', '03611500','14105700'];
    _waterData = fetchWaterData(siteCodes);
  }

  // Converts ISO 8601 dateTime string to a user-friendly format
  String formatDateTime(String isoDate) {
    try {
      DateTime parsedDate = DateTime.parse(isoDate).toLocal();
      return DateFormat('MMMM d, yyyy, h:mm a').format(parsedDate);
    } catch (e) {
      return 'Unknown Date'; // Fallback for invalid date
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false, // Extend body behind AppBar for smooth gradient
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Makes the AppBar transparent
        elevation: 0, // Removes shadow from the AppBar
        automaticallyImplyLeading: true, // Keeps the back button
        iconTheme: const IconThemeData(color: Colors.white), // Sets back arrow color to white
      ),
      backgroundColor: Colors.blueAccent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.tealAccent], // Smooth gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _waterData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final timeSeriesList = snapshot.data!['value']['timeSeries'];

                // Group data by site and display parameters
                Map<String, List<Widget>> siteData = {};

                for (var timeSeries in timeSeriesList) {
                  final siteName = timeSeries['sourceInfo']['siteName'];
                  final dateTime = timeSeries['values'][0]['value'][0]['dateTime'] ?? 'Unknown Date';
                  final parameterName = timeSeries['variable']['variableName'];
                  final value = timeSeries['values'][0]['value'][0]['value'] ?? 'N/A';

                  // Decode parameter name to handle HTML entities
                  final decodedParameterName =
                      parse(parameterName).body?.text ?? parameterName;

                  final formattedDate = formatDateTime(dateTime);

                  final entry = Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            decodedParameterName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12, // Reduced font size
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12), // Reduced font size
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            formattedDate,
                            style: const TextStyle(color: Colors.grey, fontSize: 12), // Reduced font size
                          ),
                        ),
                      ],
                    ),
                  );

                  if (!siteData.containsKey(siteName)) {
                    siteData[siteName] = [];
                  }
                  siteData[siteName]!.add(entry);
                }

                // Build the UI
                List<Widget> siteWidgets = [];
                siteData.forEach((siteName, entries) {
                  siteWidgets.add(
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$siteName',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(),
                            ...entries,
                          ],
                        ),
                      ),
                    ),
                  );
                });

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: siteWidgets,
                    ),
                  ),
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
