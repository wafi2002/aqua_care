import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatefulWidget {
  final Function(String date) onDateSelected;
  final Function(String time) onTimeSelected;

  const DateTimePickerWidget({
    super.key,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  String? selectedDate;
  String? selectedTime;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
      widget.onDateSelected(selectedDate!);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context);
      });
      widget.onTimeSelected(selectedTime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _pickDate(context),
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  labelText: selectedDate ?? "Select Date",
                  prefixIcon: Icon(Icons.calendar_today),  // Date icon on the left
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => _pickTime(context),
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  labelText: selectedTime ?? "Select Time",
                  prefixIcon: Icon(Icons.access_time),  // Time icon on the left
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
