import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDatePopup extends StatefulWidget {
  const BirthDatePopup({Key? key}) : super(key: key);

  @override
  State<BirthDatePopup> createState() => _BirthDatePopupState();
}

class _BirthDatePopupState extends State<BirthDatePopup> {
  DateTime? _selectedDate; // Null initially to enforce validation

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Choose Date',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.deepPurpleAccent.shade100,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDateComponent(
                  _selectedDate != null ? DateFormat('MMM').format(_selectedDate!) : '---'),
              const SizedBox(width: 16.0),
              _buildDateComponent(
                  _selectedDate != null ? DateFormat('dd').format(_selectedDate!) : '--'),
              const SizedBox(width: 16.0),
              _buildDateComponent(
                  _selectedDate != null ? DateFormat('yyyy').format(_selectedDate!) : '----'),
            ],
          ),
          if (_selectedDate == null)
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                'Please select a valid date.',
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ),
        ],
      ),
      actions: [
        // Cancel button
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 100),
        // OK button
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () {
              if (_selectedDate != null) {
                Navigator.of(context).pop(_selectedDate); // Pass the date back
              } else {
                setState(() {}); // Refresh to show validation message
              }
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to create each date component (Month, Day, Year)
  Widget _buildDateComponent(String dateValue) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _selectDate(context); // Open date picker on tap
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            dateValue,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Valid date range starts from 1900
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
class CustomPopup extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: onButtonPressed,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                      ),
                      child: Text(buttonText),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.check, size: 40, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SuccessPopup extends StatefulWidget {
  const SuccessPopup({Key? key}) : super(key: key);

  @override
  State<SuccessPopup> createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Success',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.deepPurpleAccent.shade100,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         Text("Data Saved Successfully", style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 18),)
        ],
      ),
      actions: [
        // Cancel button
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

      ],
    );
  }
}