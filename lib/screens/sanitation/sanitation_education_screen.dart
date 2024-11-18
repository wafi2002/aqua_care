import 'package:flutter/material.dart';

class SanitationEducationScreen extends StatelessWidget {
  const SanitationEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sanitation Education")),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Importance of Sanitation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Proper sanitation is crucial to prevent diseases and ensure a healthy environment...",
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Impact on Health",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Improper sanitation can lead to various health problems, including infections and diseases...",
                  ),
                ],
              ),
            ),
          ),
          // Add more cards for additional topics if needed
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/quiz');
            },
            child: Text("Take Quiz"),
          ),
        ],
      ),
    );
  }
}
