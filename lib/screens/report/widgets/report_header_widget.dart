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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(20),

          ),
          child: const Row(  // Wrap Text in Row
            mainAxisSize: MainAxisSize.min, // Use min size for the Row
            children: [
              Icon(
                Icons.report_problem, // Change this to your preferred icon
                color: Colors.black,
              ),
              SizedBox(width: 8), // Add spacing between icon and text
              Text(
                "Report",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
