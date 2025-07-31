import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomDateInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const CustomDateInput(
      {super.key, required this.label, required this.controller});

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                _selectDate();
              },
              icon: Icon(Icons.calendar_month)),

          TextButton(
              onPressed: () async {
                _selectDate();
              },
              child: Text(selectedDate != null
                  ? "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}"
                  : widget.label)),
        ],
      ),
    );
  }
}
