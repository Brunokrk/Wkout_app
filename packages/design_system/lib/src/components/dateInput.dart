import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomDateInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const CustomDateInput(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller});

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
          Text(widget.label),
          Spacing.horizontal(16),
          IconButton(
              onPressed: () async {
                _selectDate();
              },
              icon: Icon(Icons.calendar_month))
        ],
      ),
    );
  }
}
