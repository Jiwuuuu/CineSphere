import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF07130E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom Heart Image
            Image.asset(
              'images/thanks.png', // Replace with the correct path to your custom heart image
              height: 120,
            ),
            SizedBox(height: 20),

            // Thank You Message
            Text(
              'Thank you for your feedback!',
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                color: Color(0xFF40E49F),
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 20),

            // Quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '"Great things are done by a series of small things brought together." \n– Vincent Van Gogh',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: Color(0xFFE2F1EB),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 40),

            // Back button below the quote
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Go back to the previous screen
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8CDDBB),
                foregroundColor: Color(0xFF07130E),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
