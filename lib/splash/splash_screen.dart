import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tapti_nagrik_society/authentication/login.dart';
import 'package:tapti_nagrik_society/button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width * 0.8,
              height: height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/image/splash.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: height * 0.05), // Adjust space as needed
            CustomButton(
              title: "Next",
              width: width * 0.8,
              height: 50,
              onPressed: () {
                // Navigate to LoginView
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginView(title: "Login"),
                  ),
                );
              },
              backgroundColor: Colors.black,
              textColor: Colors.white,
              borderColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
