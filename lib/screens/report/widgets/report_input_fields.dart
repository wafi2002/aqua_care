import 'package:aqua_care/screens/report/widgets/custom_report_clipper.dart';
import 'package:flutter/material.dart';
import 'package:aqua_care/screens/report/widgets/report_card_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReportInputFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController issueController;

  const ReportInputFields({
    super.key,
    required this.nameController,
    required this.issueController,
  });

  @override
  _ReportInputFieldsState createState() => _ReportInputFieldsState();
}

class _ReportInputFieldsState extends State<ReportInputFields> {
  String? selectedDate;
  String? selectedTime;
  XFile? selectedImage; // Stores the image selected via ImageUploadWidget
  String? selectedIssue;
  TextEditingController customIssueController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final List<String> issues = [
    'Water Leakage',
    'Low Water Pressure',
    'Pipe Burst',
    'Water Quality Issue',
    'Other',
  ];

  void _onDateSelected(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _onTimeSelected(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  void _handleImagePicked(XFile? image) {
    setState(() {
      selectedImage = image;
    });
  }

  void _submitReport() async {
    if (widget.nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedIssue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return; // Exit early if fields are not filled
    }

    try {
      // Prepare the report data
      final reportData = {
        'name': widget.nameController.text,
        'address': addressController.text,
        'issue': selectedIssue == 'Other' ? customIssueController.text : selectedIssue,
        'date': selectedDate,
        'time': selectedTime,
        // Add image URLs if you're uploading images to Firebase Storage
      };

      // Save report data to Firestore
      await FirebaseFirestore.instance.collection('reports').add(reportData);

      // Show success dialog
      _showSuccessDialog();

      _clearFields(); // Clear the fields after submission
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your report has been submitted successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }


  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your report has been submitted successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _clearFields() {
    widget.nameController.clear();
    addressController.clear();
    customIssueController.clear();
    selectedDate = null;
    selectedTime = null;
    selectedIssue = null;
    setState(() {
      selectedImage = null; // Clears the selected image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomReportClipper(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlueAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: MediaQuery.of(context).size.height,
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: ReportCardWidget(
              nameController: widget.nameController,
              addressController: addressController,
              customIssueController: customIssueController,
              selectedIssue: selectedIssue,
              onIssueChanged: (String? newValue) {
                setState(() {
                  selectedIssue = newValue;
                  if (newValue == 'Other') {
                    customIssueController.clear();
                  }
                });
              },
              onDateSelected: _onDateSelected,
              onTimeSelected: _onTimeSelected,
              onImagePicked: _handleImagePicked,
              onSubmit: _submitReport,
            ),
          ),
        ),
      ],
    );
  }
}

