import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'date_time_picker.dart';
import 'image_upload_widget.dart';
import 'report_header_widget.dart';
import 'issue_dropdown_widget.dart';

class ReportCardWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController customIssueController;
  final String? selectedIssue;
  final Function(String?) onIssueChanged;
  final Function(String) onDateSelected;
  final Function(String) onTimeSelected;
  final Function(XFile?) onImagePicked;
  final VoidCallback onSubmit;

  const ReportCardWidget({
    super.key,
    required this.nameController,
    required this.addressController,
    required this.customIssueController,
    required this.selectedIssue,
    required this.onIssueChanged,
    required this.onDateSelected,
    required this.onTimeSelected,
    required this.onImagePicked,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReportHeaderWidget(),
          const SizedBox(height: 10),
          _buildTextField(nameController, "Complainant", icon: Icons.person),
          const SizedBox(height: 10),
          _buildAddressField(),
          const SizedBox(height: 10),
          IssueDropdownWidget(
            selectedIssue: selectedIssue,
            onChanged: onIssueChanged,
          ),
          const SizedBox(height: 10),
          if (selectedIssue == 'Other') _buildCustomIssueField(),
          const SizedBox(height: 10),
          DateTimePickerWidget(
            onDateSelected: onDateSelected,
            onTimeSelected: onTimeSelected,
          ),
          const SizedBox(height: 10),
          ImageUploadWidget(
            onImagePicked: onImagePicked,
          ),
          const SizedBox(height: 20),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildAddressField() {
    return _buildTextField(
      addressController, "Incident Address",
      icon: Icons.location_on,
      isLargeField: true,
      minLines: 3,
      maxLines: null,
    );
  }

  Widget _buildCustomIssueField() {
    return TextField(
      controller: customIssueController,
      decoration: const InputDecoration(
        hintText: "Please specify your issue...",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.send,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label, {
        bool isPassword = false,
        bool isLargeField = false,
        IconData? icon,
        int? minLines,
        int? maxLines,
      }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      minLines: minLines ?? 1,
      maxLines: isLargeField ? (maxLines ?? 3) : 1,
      decoration: InputDecoration(
        labelText: label,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }
}
