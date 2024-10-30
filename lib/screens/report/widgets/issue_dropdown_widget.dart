import 'package:flutter/material.dart';

class IssueDropdownWidget extends StatelessWidget {
  final String? selectedIssue;
  final Function(String?) onChanged;

  IssueDropdownWidget({
    super.key,
    required this.selectedIssue,
    required this.onChanged,
  });

  final List<String> issues = [
    'Water Leakage',
    'Low Water Pressure',
    'Pipe Burst',
    'Water Quality Issue',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Select Issue",
        border: OutlineInputBorder(),
      ),
      value: selectedIssue,
      items: issues.map((String issue) {
        return DropdownMenuItem<String>(
          value: issue,
          child: Text(issue),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
