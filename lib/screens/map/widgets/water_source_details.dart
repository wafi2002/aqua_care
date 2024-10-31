import 'package:flutter/material.dart';

class WaterSourceDetails extends StatelessWidget {
  final String sourceName;

  const WaterSourceDetails({super.key, required this.sourceName});

  // Create a map to hold descriptions for different sources
  final Map<String, String> sourceDescriptions = const {
    'Pengurusan Air Pahang Berhad':
    'Pengurusan Air Pahang Berhad (PAPB) is a state-owned water supply company in Pahang, Malaysia, focused on delivering treated water to residents. It oversees water treatment and distribution, promotes water conservation, and uses modern technology for efficient service. PAPB plays a key role in ensuring clean water access while engaging with the community through educational initiatives.',
    'Lembaga Air Perak':
    'Lembaga Air Perak (LAP) is the state-owned water authority in Perak, Malaysia, tasked with managing and distributing clean water. It ensures sustainable water supply and quality standards while enhancing infrastructure like treatment plants. LAP promotes water conservation through community outreach and invests in technology to improve efficiency and meet urban demands.',

  };

  // Create a map to hold contact information for different sources
  final Map<String, String> sourceContacts = const {
    'Pengurusan Air Pahang Berhad': 'Contact: 123-456-7890, Email: contact@papb.com.my',
    'Lembaga Air Perak': 'Contact: 123-456-7890, Email: contact@airperak.com.my',

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sourceName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade100, // Lighter blue for a softer look
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getSourceImage(sourceName),
            const SizedBox(height: 20),
            // Adding a border for detail sections
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the description based on the source name
                  Text(
                    sourceDescriptions[sourceName] ?? 'Description not available.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black, // Softer black color
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Contact Information Container with icons in a column
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600, // Light blue background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0), // Add left margin
                          child: Row(
                            children: [
                              const Icon(Icons.contact_phone, color: Colors.white), // Phone icon
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  // Extract contact information
                                  sourceContacts[sourceName]?.split(',')[0].replaceFirst('Contact: ', '') ?? 'Contact information not available.',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8), // Spacing between rows
                        Container(
                          margin: const EdgeInsets.only(left: 16.0), // Add left margin
                          child: Row(
                            children: [
                              const Icon(Icons.email, color: Colors.white), // Email icon
                              const SizedBox(width: 8), // Spacing between icon and text
                              Expanded(
                                child: Text(
                                  // Extract email information
                                  sourceContacts[sourceName]?.split(',')[1].replaceFirst('Email: ', '') ?? 'Email not available.',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSourceImage(String sourceName) {
    // Return an image based on the source name
    switch (sourceName) {
      case 'Pengurusan Air Pahang Berhad':
        return Image.asset(
          'assets/images/paip.JPG',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      case 'Lembaga Air Perak':
        return Image.asset(
          'assets/images/lap.jpg',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      case 'well':
        return Image.asset(
          'assets/images/well.png',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
    // Add more cases for different sources as needed
      default:
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade300,
          alignment: Alignment.center,
          child: const Text(
            'No Image Available',
            style: TextStyle(color: Colors.black54),
          ),
        );
    }
  }
}
