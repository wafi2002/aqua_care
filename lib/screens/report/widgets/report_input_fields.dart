import 'dart:io';
import 'package:aqua_care/models/report.dart';
import 'package:aqua_care/screens/report/widgets/custom_report_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aqua_care/screens/report/widgets/report_card_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';



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
  XFile? selectedImage;
  String? selectedIssue;
  bool _isLoading = false;
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
        selectedIssue == null ||
        (selectedIssue == 'Other' && customIssueController.text.isEmpty) ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl;
      if (selectedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('report_images/${selectedImage!.name}');
        await storageRef.putFile(File(selectedImage!.path));
        imageUrl = await storageRef.getDownloadURL();
      }

      final currentUser = FirebaseAuth.instance.currentUser;
      final report = Report(
        name: widget.nameController.text,
        address: addressController.text,
        issue: selectedIssue == 'Other' ? customIssueController.text : selectedIssue!,
        date: selectedDate!,
        time: selectedTime!,
        imageUrl: imageUrl,
        userId: currentUser?.uid ?? '', // Include user ID
      );

      await FirebaseFirestore.instance.collection('reports').add(report.toMap());

      setState(() {
        _isLoading = false;
      });

      _showAnimatedSuccessDialog();
      _clearFields();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _showAnimatedSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildSuccessDialogContent(),
        );
      },
    );
  }

  Widget _buildSuccessDialogContent() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              size: 70.0,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            const Text(
              'Success',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Your report has been submitted successfully!',  textAlign: TextAlign.center,),
            const SizedBox(height: 20),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
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
      selectedImage = null;
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
            child: Column(
              children: [
                ReportCardWidget(
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
              ],
            ),
          ),
        ),
        if (_isLoading) // Overlay loading indicator when `_isLoading` is true
          Center(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent background
              child: const Center(
                child: CircularProgressIndicator(), // Loading spinner
              ),
            ),
          ),
      ],
    );
  }
}


