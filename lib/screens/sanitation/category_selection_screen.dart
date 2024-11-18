import 'package:aqua_care/screens/sanitation/sanitation_quiz_screen.dart';
import 'package:flutter/material.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "General Knowledge", "icon": Icons.book},
    {"name": "Health Benefits", "icon": Icons.health_and_safety},
    {"name": "Water Purification", "icon": Icons.water_drop},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false, // Ensures content extends behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Makes the AppBar transparent
        elevation: 0, // Removes shadow from the AppBar
        automaticallyImplyLeading: true, // Keeps the back button
          iconTheme: const IconThemeData(color: Colors.white)
      ),
      backgroundColor: Colors.teal,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blue], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent.withOpacity(0.1), // Light background color for icon
                  radius: 24, // Size of the CircleAvatar
                  child: Icon(
                    categories[index]["icon"],
                    size: 28, // Icon size
                    color: Colors.blueAccent, // Icon color
                  ),
                ),
                title: Text(
                  categories[index]["name"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.blueAccent,
                  size: 28,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SanitationQuizScreen(category: categories[index]["name"]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
