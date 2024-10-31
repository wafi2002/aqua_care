import 'package:aqua_care/screens/report/widgets/report_history_screen.dart';
import 'package:flutter/material.dart';

class ReportHeaderWidget extends StatelessWidget {
  const ReportHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            "Something happen?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // Navigate to the report history screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportHistoryScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107), // Button background color
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                textStyle: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.document_scanner,
                    color: Colors.white,
                  ),
                  Text(
                    "Report History",
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ],
    );
  }
}
