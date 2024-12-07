import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapti_nagrik_society/button.dart';
import 'package:tapti_nagrik_society/database/database.dart';
import 'package:tapti_nagrik_society/textfield/textfield.dart';

import '../popup/popup.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController fathername = TextEditingController();
  final TextEditingController husbandname = TextEditingController();
  final TextEditingController adharNumber = TextEditingController();
  final TextEditingController nomineeName = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController openingDate = TextEditingController();
  final TextEditingController ansh = TextEditingController();
  final TextEditingController anshAmount = TextEditingController();
  final TextEditingController entryFee = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController memberId = TextEditingController();
  String _anshValue = '1';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _selectDatePopup(BuildContext context,) async {
    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return const BirthDatePopup();
      },
    );

    if (selectedDate != null) {
      setState(() {
        dateOfBirth.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }
  void _selectOpenDatePopup(BuildContext context,) async {
    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return const BirthDatePopup();
      },
    );

    if (selectedDate != null) {
      setState(() {
        openingDate.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  // Validation logic
  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required.';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number.';
    }
    return null;
  }

  String? _validateAadhar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Aadhar number is required.';
    }
    if (!RegExp(r'^\d{12}$').hasMatch(value)) {
      return 'Enter a valid 12-digit Aadhar number.';
    }
    return null;
  }

  void _submitForm(BuildContext) async {
    if (_formKey.currentState?.validate() ?? false) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        await DatabaseService.insertUserDetails(
          context: context,
          fullname: fullname.text,
          fathername: fathername.text,
          husbandname: husbandname.text.isNotEmpty ? husbandname.text : 'N/A',
          adharno: int.parse(adharNumber.text),
          nomineename: nomineeName.text.isNotEmpty ? nomineeName.text : 'N/A',
          mobileno: int.parse(mobileNo.text),
          address: address.text,
          openingdate: openingDate.text,
          dateofbirth: dateOfBirth.text,
          ansh: int.parse(_anshValue),
          anshamt: int.parse(anshAmount.text),
          entryFees: int.parse(entryFee.text),
          memberId: memberId.text,
        );
      } catch (e) {
        print('Error saving user: $e');
      } finally {
        Navigator.of(context).pop(); // Remove loading indicator
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form.')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registration",
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.white, size: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey, // Assigning the Form key
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        CustomTextField(
                          label: "Full name",
                          controller: fullname,
                          validator: (value) => _validateNotEmpty(value, 'Full name'),
                        ),
                        CustomTextField(
                          label: "Father's name",
                          controller: fathername,
                          validator: (value) => _validateNotEmpty(value, 'Father\'s name'),
                        ),
                        CustomTextField(
                          label: "Husband's name",
                          controller: husbandname,
                        ),
                        CustomTextField(
                          label: "Aadhar Number",
                          controller: adharNumber,
                          validator: _validateAadhar,
                        ),
                        CustomTextField(
                          label: "Nominee Name",
                          controller: nomineeName,
                        ),
                        CustomTextField(
                          label: "Mobile Number",
                          controller: mobileNo,
                          validator: _validateMobile,
                        ),
                        CustomTextField(
                          label: "Address",
                          controller: address,
                          validator: (value) => _validateNotEmpty(value, 'Address'),
                        ),
                        CustomTextField(
                          label: "Opening date",
                          controller: openingDate,

                          isReadOnly: true,
                          onTap: () {
                            _selectOpenDatePopup(context);

                          },
                        ),
                        CustomTextField(
                          label: "Member id",
                          controller: memberId,

                          isReadOnly: false,
                          validator:(value)=> _validateNotEmpty(value, 'Member ID')
                        ),
                        DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.circular(15),
                          dropdownColor: Colors.indigo.shade100,
                          value: _anshValue,
                          items: ['1', '2', '3'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _anshValue = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Ansh',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        CustomTextField(
                          label: "Ansh Amount",
                          controller: anshAmount,
                        ),
                        CustomTextField(
                          label: "Entry Fee",
                          controller: entryFee,
                        ),
                        CustomTextField(
                          label: "Date of Birth",
                          controller: dateOfBirth,
                          isReadOnly: true,
                          onTap: () {
                            _selectDatePopup(context);
                          },
                        ),
                        CustomButton(
                          onPressed: () {_submitForm(context);},
                          backgroundColor: Colors.pink,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          title: "Submit",
                        )
                      ].map((field) {
                        return isWeb
                            ? SizedBox(
                            width: MediaQuery.of(context).size.width / 3 - 24, child: field)
                            : SizedBox(
                            width: MediaQuery.of(context).size.width - 24, child: field);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
