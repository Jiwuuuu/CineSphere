// splash_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Ensure this path is correct
import 'welcome_manager.dart'; // Ensure this path is correct
// Ensure this path is correct

const header_text = Color(0xff40E49F);

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay to check if first-time user and navigate accordingly
    Future.delayed(const Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      if (isFirstTime) {
        await prefs.setBool('isFirstTime', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeManager()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Image.asset(
              'images/Logo.png', // Replace with your logo asset path
              height: 100, // Adjust the height as needed
            ),
            const SizedBox(height: 20), // Spacing between image and text
            Text(
              "CINESPHERE",
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: header_text, // Use header_text color
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
