import 'package:http/http.dart' as http;
import 'dart:convert';

// Function to fetch water data for multiple sites
Future<Map<String, dynamic>> fetchWaterData(List<String> siteCodes) async {
  const String parameterCode = '00065,00010,00400,00300,00060'; // Parameter codes for multiple parameters
  final String siteCodeString = siteCodes.join(','); // Join site codes into a comma-separated string
  final String url =
      'https://waterservices.usgs.gov/nwis/iv/?sites=$siteCodeString&parameterCd=$parameterCode&format=json';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Parsing the JSON response into a Map
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load water data');
  }
}
