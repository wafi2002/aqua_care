import 'package:aqua_care/screens/report/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'image_upload_widget.dart';

class EditReportScreen extends StatefulWidget {
  final String reportId;

  const EditReportScreen({super.key, required this.reportId});

  @override
  _EditReportScreenState createState() => _EditReportScreenState();
}

class _EditReportScreenState extends State<EditReportScreen> {
  final TextEditingController issueController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  XFile? _image;
  String? selectedDate;
  String? selectedTime;
  String? selectedIssue; // To store selected issue
  bool isOtherSelected = false; // Track if "Other" is selected

  final List<String> issues = [
    'Water Leakage',
    'Low Water Pressure',
    'Pipe Burst',
    'Water Quality Issue',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _loadReportData();
  }

  Future<void> _loadReportData() async {
    DocumentSnapshot reportDoc = await FirebaseFirestore.instance
        .collection('reports')
        .doc(widget.reportId)
        .get();

    if (reportDoc.exists) {
      Map<String, dynamic> data = reportDoc.data() as Map<String, dynamic>;
      issueController.text = data['issue'] ?? '';
      nameController.text = data['name'] ?? '';
      addressController.text = data['address'] ?? '';
      selectedDate = data['date'] ?? '';
      selectedTime = data['time'] ?? '';
      selectedIssue = data['issue'] ?? ''; // Load the selected issue

      setState(() {
        isOtherSelected = selectedIssue == 'Other';
        _image = null;
      });
    }
  }

  Future<void> _updateReport() async {
    await FirebaseFirestore.instance
        .collection('reports')
        .doc(widget.reportId)
        .update({
      'issue': isOtherSelected ? issueController.text : selectedIssue,
      'name': nameController.text,
      'address': addressController.text,
      'date': selectedDate,
      'time': selectedTime,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Report'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0), // Padding inside the container
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.yellow.shade100, // Background color of the container
          borderRadius: BorderRadius.circular(10), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Complainant',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedIssue,
                items: issues.map((String issue) {
                  return DropdownMenuItem<String>(
                    value: issue,
                    child: Text(issue),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedIssue = newValue;
                    isOtherSelected = newValue == 'Other';
                    if (!isOtherSelected) issueController.clear();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Issue',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              if (isOtherSelected)
                TextField(
                  controller: issueController,
                  decoration: InputDecoration(
                    labelText: 'Specify Issue',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              DateTimePickerWidget(
                onDateSelected: (String date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
                onTimeSelected: (String time) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ImageUploadWidget(
                onImagePicked: (XFile? image) {
                  setState(() {
                    _image = image;
                  });
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: 200, // Set the desired width here
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.greenAccent.shade400, // Text color
                  ),
                  onPressed: _updateReport,
                  child: const Text('Update',style: TextStyle(
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
