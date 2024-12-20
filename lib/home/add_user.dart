import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapti_nagrik_society/button.dart';
import 'package:tapti_nagrik_society/database/database.dart';
import 'package:tapti_nagrik_society/home/dds.dart';
import 'package:tapti_nagrik_society/home/saving.dart';
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
  final TextEditingController calculateAnshAmt = TextEditingController();
  final TextEditingController entryFee = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController memberId = TextEditingController();
  String _anshValue = '1';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    calculateAnshAmtData();
    DatabaseHelper.instance.database;
    anshAmount.addListener(() {
      calculateAnshAmtData();
    });

  }

  void saveMember() {
    final newMember = Member(
      fullname: fullname.text,
      fathername: fathername.text,
      husbandname: husbandname.text,
      adharNumber: adharNumber.text,
      nomineeName: nomineeName.text,
      mobileNo: mobileNo.text,
      address: address.text,
      openingDate: openingDate.text,
      ansh: ansh.text,
      anshAmount: calculateAnshAmt.text,
      entryFee: entryFee.text,
      dateOfBirth: dateOfBirth.text,
      memberId: memberId.text,
    );

    DatabaseHelper.instance.insertMember(newMember).then((id) {
      if (id > 0) {
        print("save");
        _showSuccessPopup(context);
      }
    });
  }

  Future<void> _selectDatePopup(BuildContext context, TextEditingController controller) async {
    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return const BirthDatePopup();
      },
    );

    if (selectedDate != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

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

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: "Success",
          description: "User details saved successfully!",
          buttonText: "Okay",
          onButtonPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Saving()));
          },
        );
      },
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        saveMember();

      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving user: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form.')),
      );
    }
  }
  void calculateAnshAmtData() {
    final anshAmountValue = int.tryParse(anshAmount.text) ?? 0;
    final anshValue = int.tryParse(_anshValue) ?? 1;
    final calculatedValue = anshAmountValue * anshValue;

    setState(() {
      calculateAnshAmt.text = calculatedValue.toString();
    });
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
          onPressed: () {
            Navigator.pop(context);
          },
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
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildCustomTextField(label: "Full name", controller: fullname, validator: (value) => _validateNotEmpty(value, 'Full name')),
                        _buildCustomTextField(label: "Father's name", controller: fathername, validator: (value) => _validateNotEmpty(value, 'Father\'s name')),
                        _buildCustomTextField(label: "Husband's name", controller: husbandname),
                        _buildCustomTextField(label: "Aadhar Number", controller: adharNumber, validator: _validateAadhar),
                        _buildCustomTextField(label: "Nominee Name", controller: nomineeName),
                        _buildCustomTextField(label: "Mobile Number", controller: mobileNo, validator: _validateMobile),
                        _buildCustomTextField(label: "Address", controller: address, validator: (value) => _validateNotEmpty(value, 'Address')),
                        _buildCustomTextField(
                          label: "Opening date",
                          controller: openingDate,
                          isReadOnly: true,
                          onTap: () => _selectDatePopup(context, openingDate),
                        ),
                        _buildCustomTextField(label: "Member id", controller: memberId, validator: (value) => _validateNotEmpty(value, 'Member ID')),
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
                            calculateAnshAmtData();
                          },
                          decoration: const InputDecoration(
                            labelText: 'Ansh',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        _buildCustomTextField(label: "Ansh Amount", controller: anshAmount),
                        _buildCustomTextField(label: "Calculated ansh amount", controller: calculateAnshAmt),
                        _buildCustomTextField(label: "Entry Fee", controller: entryFee),
                        _buildCustomTextField(
                          label: "Date of Birth",
                          controller: dateOfBirth,
                          isReadOnly: true,
                          onTap: () => _selectDatePopup(context, dateOfBirth),
                        ),
                        CustomButton(
                          onPressed: () => _submitForm(),
                          backgroundColor: Colors.pink,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          title: "Submit",
                        )
                      ].map((field) {
                        return isWeb
                            ? SizedBox(width: MediaQuery.of(context).size.width / 3 - 24, child: field)
                            : SizedBox(width: MediaQuery.of(context).size.width - 24, child: field);
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

  Widget _buildCustomTextField({required String label, required TextEditingController controller, String? Function(String?)? validator, bool isReadOnly = false, void Function()? onTap}) {
    return CustomTextField(
      label: label,
      controller: controller,
      validator: validator,
      isReadOnly: isReadOnly,
      onTap: onTap,
    );
  }
}
