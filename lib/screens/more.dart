import 'package:cinesphere/screens/faqs.dart';
import 'package:cinesphere/screens/terms_and_conditions.dart';
import 'package:cinesphere/screens/tickets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinesphere/screens/about_us.dart';
import 'package:cinesphere/screens/feedback.dart';
import 'package:cinesphere/screens/home_screen.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF07130E),
      appBar: AppBar(
        backgroundColor: Color(0xFF07130E),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            "More",
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              color: Color(0xFF8CDDBB),
              fontSize: 35,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Center(
              child: Image.asset(
                'images/Logo.png', // Replace with your logo path if applicable
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildMoreOption(context, 'images/icons/info.png', "About Us", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                  }),
                  Divider(color: Color(0xFF8CDDBB), thickness: 1),

                  _buildMoreOption(context, 'images/icons/rate.png', "Feedback", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackScreen()),
                    );
                  }),
                  Divider(color: Color(0xFF8CDDBB), thickness: 1),

                  _buildMoreOption(context, 'images/icons/help.png', "Contact Us", () {
                    // Add Contact Us navigation here
                  }),
                  Divider(color: Color(0xFF8CDDBB), thickness: 1),

                  _buildMoreOption(context, 'images/icons/help.png', "FAQs", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQsScreen()),
                    );
                  }),
                  Divider(color: Color(0xFF8CDDBB), thickness: 1),

                  _buildMoreOption(context, 'images/icons/terms-and-conditions.png', "Terms & Conditions", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()),
                    );
                  }),
                  Divider(color: Color(0xFF8CDDBB), thickness: 1),

                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Version 1.0.0',
                      style: GoogleFonts.lexend(
                        color: Color(0xFF8CDDBB),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedTab: 'More', onTabSelected: (tab) {}),
    );
  }

  Widget _buildMoreOption(BuildContext context, String imagePath, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: GoogleFonts.lexend(
                color: Color(0xFF8CDDBB),
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;

  const BottomNavBar({
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Container(
        width: containerWidth,
        height: 90,
        child: Stack(
          children: [
            Container(
              width: containerWidth,
              height: 70,
              decoration: ShapeDecoration(
                color: Color(0xFF07130E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3D40E49F),
                    blurRadius: 18.4,
                    offset: Offset(0, 0),
                    spreadRadius: 2.0,
                  ),
                ],
              ),
            ),
            _buildNavItem(context, containerWidth * 0.1, 'Tickets', 'images/icons/transaction.png', () {
              onTabSelected("Tickets");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TicketScreen()),
              );
            }, selectedTab == "Tickets"),
            _buildNavItem(context, containerWidth * 0.45, 'Home', 'images/icons/home.png', () {
              onTabSelected("Home");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }, selectedTab == "Home"),
            _buildNavItem(context, containerWidth * 0.8, 'More', 'images/icons/mores.png', () {
              onTabSelected("More");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MoreScreen()),
              );
            }, selectedTab == "More"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, double left, String label, String iconPath, VoidCallback onTap, bool isSelected) {
    return Positioned(
      left: left,
      top: 16,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              iconPath,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          if (isSelected)
            Container(
              width: 40,
              height: 2,
              color: Color(0xFF8CDDBB),
            ),
        ],
      ),
    );
  }
}
