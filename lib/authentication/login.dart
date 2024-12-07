import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../button.dart';
import '../home/home.dart';
import '../textfield/textfield.dart';

class LoginView extends StatefulWidget {
  final String title;
  const LoginView({super.key, required this.title});
  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void validation(BuildContext context, String username, String password) {
    if (username.isEmpty && password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Validation', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),),
            content: Text('Both username and password are required.',
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if(username.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Validation', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),),
            content: Text('Both username and password are required.',
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if(password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Validation', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),),
            content: Text('Both username and password are required.',
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if(username == "admin" && password == 'Kamlesh@8665') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeView(title: "Home",),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 600; // Simple breakpoint for web vs. mobile

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_sharp, color: Colors.white, size: 20),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isWeb ? 500 : double.infinity, // Limit width on larger screens
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(label: "Admin Username", controller: _userNameController),
                SizedBox(height: width * 0.04),
                TextfieldPassword(label: "Admin Password", controller: _passwordController),
                SizedBox(height: width * 0.08),
                CustomButton(
                  onPressed: () {
                    validation(context, _userNameController.text, _passwordController.text);
                  },
                  title: "Submit",
                  backgroundColor: Colors.black87,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}