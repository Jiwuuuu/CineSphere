import 'package:cinesphere/screens/about_us_screen.dart';
import 'package:cinesphere/screens/terms_of_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinesphere/main.dart';
import 'ticket_screen.dart';
import 'home_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int _currentIndex = 2; // Set current index for "More" screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF07130E),
      appBar: AppBar(
        backgroundColor: Color(0xFF07130E),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              // Logo at the top of the screen
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  'images/Logo.png', // Replace with the correct logo path
                  height: 100,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  children: [
                    // About Us
                    _buildListTile(
                      context,
                      icon: Icons.info,
                      title: 'About Us',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUsScreen()),
                        );
                      },
                    ),
                    // Feedback
                    _buildListTile(
                      context,
                      icon: Icons.feedback,
                      title: 'Feedback',
                      onTap: () {
                        // Handle navigation to Feedback screen
                      },
                    ),
                    // Contact Us
                    _buildListTile(
                      context,
                      icon: Icons.contact_phone,
                      title: 'Contact Us',
                      onTap: () {
                        // Handle navigation to Contact Us screen
                      },
                    ),
                    // FAQs
                    _buildListTile(
                      context,
                      icon: Icons.help,
                      title: 'FAQs',
                      onTap: () {
                        // Handle navigation to FAQs screen
                      },
                    ),
                    // Terms of Service
                    _buildListTile(
                      context,
                      icon: Icons.description,
                      title: 'Terms of Service',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TermsOfServiceScreen()),
                        );
                      },
                    ),
                    // Version Info (Now positioned above the Navbar)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'Version 1.0.0',
                          style: GoogleFonts.lexend(
                            color: Color(0xFF8CDDBB),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Bottom Navigation Bar fixed at the bottom
          Positioned(
            bottom: 20, // Consistent distance from the bottom of the screen
            left: MediaQuery.of(context).size.width * 0.1, // Center it horizontally
            right: MediaQuery.of(context).size.width * 0.1,
            child: BottomNavBar(
              currentIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                  // Handle navigation based on index
                  if (_currentIndex == 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else if (_currentIndex == 0) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TicketScreen()),
                    );
                  } else if (_currentIndex == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MoreScreen()),
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF8CDDBB)),
        title: Text(
          title,
          style: GoogleFonts.lexend(color: Color(0xFFE2F1EB), fontSize: 20),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
