import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiAPI {
  final String apiKey = const String.fromEnvironment('AIzaSyCUizJp7InT5_vskn2xfOlMFFsvahH9Vas');

  GeminiAPI() {
    if (apiKey.isEmpty) {
      throw Exception('API Key not found! Set the API_KEY environment variable.');
    }
  }

  Future<String> getEducationalContent(String topic) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );

    final prompt = 'Educational content on $topic';
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No content received from the API';
  }
}
