import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tapti_nagrik_society/button.dart';
import 'package:tapti_nagrik_society/home/home.dart';
import 'package:tapti_nagrik_society/popup/popup.dart';
import '../database/database.dart';
import '../textfield/textfield.dart'; // Adjust this import based on your actual file path

class Saving extends StatefulWidget {
  const Saving({super.key});

  @override
  State<Saving> createState() => _SavingState();
}

class _SavingState extends State<Saving> {
  List<Member> members = [];

  @override
  void initState() {
    super.initState();
    fetchMembers();
  }

  void fetchMembers() async {
    final fetchedMembers = await DatabaseHelper.instance.getAllMembers(); // Replace with your database fetching logic
    setState(() {
      members = fetchedMembers;
    });
  }

  Widget buildUserCell(Member user, BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CustomBottomSheet(user: user,onUpdate: (updatedUser) {
                setState(() {
                  // Update the member in the list
                  final index = members.indexWhere((m) => m.id == updatedUser.id);
                  if (index != -1) {
                    members[index] = updatedUser;
                  }
                });

                // Update the database
                DatabaseHelper.instance.updateMember(updatedUser);
              },);
            },
          );
        },
        child: Card(

          color: Colors.white,
          borderOnForeground: true,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          elevation: 4,
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Details", textAlign: TextAlign.center,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.indigo.shade500)),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,              children: [
                  Text("Full name : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Text("${user.fullname}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
                ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Father name : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text("${user.fathername}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mobile no : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text("${user.mobileNo}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Opening Date : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text("${user.openingDate}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Adhar number : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text("${user.adharNumber}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Address : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text("${user.address}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ansh amount : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text("${user.anshAmount}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Daily Saving", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        leading: IconButton(icon: Icon(Icons.keyboard_arrow_left), onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeView(title: "Home")));
        }, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return buildUserCell(members[index],context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final Member user;
  final Function(Member updatedUser) onUpdate;

  // Controllers for TextFields
  final TextEditingController fullnameController;
  final TextEditingController fathernameController;
  final TextEditingController husbandnameController;
  final TextEditingController adharNumberController;
  final TextEditingController nomineeNameController;
  final TextEditingController mobileNoController;
  final TextEditingController addressController;
  final TextEditingController openingDateController;
  final TextEditingController anshController;
  final TextEditingController anshAmountController;
  final TextEditingController entryFeeController;
  final TextEditingController dateOfBirthController;
  final TextEditingController memberIdController;

  CustomBottomSheet({required this.user, required this.onUpdate})
      : fullnameController = TextEditingController(text: user.fullname),
        fathernameController = TextEditingController(text: user.fathername),
        husbandnameController = TextEditingController(text: user.husbandname),
        adharNumberController = TextEditingController(text: user.adharNumber),
        nomineeNameController = TextEditingController(text: user.nomineeName),
        mobileNoController = TextEditingController(text: user.mobileNo),
        addressController = TextEditingController(text: user.address),
        openingDateController = TextEditingController(text: user.openingDate),
        anshController = TextEditingController(text: user.ansh),
        anshAmountController = TextEditingController(text: user.anshAmount),
        entryFeeController = TextEditingController(text: user.entryFee),
        dateOfBirthController = TextEditingController(text: user.dateOfBirth),
        memberIdController = TextEditingController(text: user.memberId);

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12, width: 0.5),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Update Details",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.indigo,
                ),
              ),
              const Divider(color: CupertinoColors.opaqueSeparator),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              // List of CustomTextFields
              CustomTextField(label: "Full Name", controller: fullnameController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Father Name", controller: fathernameController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Husband Name", controller: husbandnameController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Mobile No", controller: mobileNoController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Opening Date", controller: openingDateController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Adhar Number", controller: adharNumberController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Address", controller: addressController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Ansh Amount", controller: anshAmountController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Opening Date", controller: openingDateController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Entry fee", controller: entryFeeController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "date of birth", controller: dateOfBirthController),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              CustomTextField(label: "Member id", controller: memberIdController),
              const SizedBox(height: 20),
              CustomButton(
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                onPressed: () async {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomPopup(
                        title: "Success",
                        description: "Member details updated successfully.",
                        buttonText: "OK",
                        onButtonPressed: () {
                          if (_validateFields(context)) {
                            final updatedMember = Member(
                              id: user.id,
                              fullname: fullnameController.text,
                              fathername: fathernameController.text,
                              husbandname: husbandnameController.text,
                              adharNumber: adharNumberController.text,
                              nomineeName: user.nomineeName, // Unchanged
                              mobileNo: mobileNoController.text,
                              address: addressController.text,
                              openingDate: openingDateController.text,
                              ansh: user.ansh, // Unchanged
                              anshAmount: anshAmountController.text,
                              entryFee: user.entryFee, // Unchanged
                              dateOfBirth: user.dateOfBirth, // Unchanged
                              memberId: user.memberId, // Unchanged
                            );

                            onUpdate(updatedMember); // Send updated user back
                            Navigator.pop(context); // Close bottom sheet
                          }
                          //onUpdate(updatedMember);
                          DatabaseHelper.instance.getAllMembers();
                        },
                      );
                    },
                  );

                },
                title: "Update",
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Validation function
  bool _validateFields(BuildContext context) {
    if (fullnameController.text.isEmpty ||
        mobileNoController.text.isEmpty ||
        addressController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Validation Error"),
          content: const Text("Please fill in all required fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }
}


