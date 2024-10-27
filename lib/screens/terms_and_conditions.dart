import 'package:cinesphere/main.dart';
import 'package:cinesphere/screens/home_screen.dart';
import 'package:cinesphere/screens/more.dart';
import 'package:cinesphere/screens/tickets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: bg_color,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              'images/Logo.png',
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(
              "TERMS OF SERVICE",
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: Color(0xFF39C55C),
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Effective Date: October 27, 2024",
              style: GoogleFonts.lexend(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionHeader("Introduction"),
              const SizedBox(height: 10),
              _buildParagraph("Welcome to CineSphere!"),
              _buildParagraph(
                  "By accessing or using our mobile app, you agree to comply with and be bound by the following terms and conditions. These terms govern your use of CineSphere's services, ensuring a smooth and enjoyable experience for everyone."),
              const SizedBox(height: 20),
              _buildSectionHeader("Acceptance of Terms"),
              const SizedBox(height: 10),
              _buildParagraph(
                  "By browsing movies, booking tickets, or otherwise using the CineSphere app, you are agreeing to these terms. If you do not agree, please discontinue using our app."),
              const SizedBox(height: 20),
              _buildSectionHeader("Usage Guidelines"),
              const SizedBox(height: 10),
              _buildParagraph(
                  "CineSphere is designed to make cinema experiences more accessible. Users are expected to use the app responsibly, which includes following proper booking processes and adhering to any applicable cinema policies. Misuse of the app may result in restricted access."),
              const SizedBox(height: 20),
              _buildSectionHeader("Payments and Refunds"),
              const SizedBox(height: 10),
              _buildParagraph(
                  "Payments are made through our app using secure methods. All bookings are final, and refunds are generally not provided unless a screening is canceled by the cinema. Please ensure you check the details carefully before completing a booking."),
              const SizedBox(height: 20),
              _buildSectionHeader("Limitations of Liability"),
              const SizedBox(height: 10),
              _buildParagraph(
                  "CineSphere aims to provide a reliable service, but we are not responsible for missed movie screenings, errors in ticket availability, or technical issues. Users understand and agree that CineSphere is not liable for losses or damages resulting from these situations."),
              const SizedBox(height: 20),
              _buildSectionHeader("Modifications of Terms"),
              const SizedBox(height: 10),
              _buildParagraph(
                  "CineSphere reserves the right to modify these terms at any time. Users will be notified of any updates, and continued use of the app after such modifications will constitute acceptance of the updated terms."),
              const SizedBox(height: 20),
              _buildQuote(
                  "Great cinema brings people together, and our goal is to ensure that everyone can experience it seamlessly."),
              const SizedBox(height: 20),
              _buildSectionHeader("Contact Information"),
              const SizedBox(height: 10),
              _buildParagraph(
                  "If you have any questions or concerns about these Terms & Conditions, please contact us at andr.amrinto@gmail.com"),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  '© 2024 CineSphere. All rights reserved.',
                  style: GoogleFonts.lexend(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedTab: 'More',
        onTabSelected: (tab) {
          // Handle navigation based on the selected tab
          switch (tab) {
            case "Home":
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case "Tickets":
              // Navigate to Tickets Screen (Placeholder)
              break;
            case "More":
              // Stay on the current screen
              break;
          }
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.lexend(
        color: Color(0xFF39C55C),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.lexend(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Widget _buildQuote(String quote) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xFF39C55C), width: 3)),
      ),
      child: Text(
        '"$quote"',
        style: GoogleFonts.lexend(
          color: Colors.white,
          fontSize: 18,
          fontStyle: FontStyle.italic,
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
      padding: const EdgeInsets.symmetric(horizontal: 50.0), // Add padding to the entire navigation bar
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
            Positioned(
              left: containerWidth * 0.1,
              top: 16,
              child: Column(
                children: [
                  GestureDetector(
                  onTap: () {
                    onTabSelected("Ticket");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TicketScreen()),
                    );
                  },
                  child: Image.asset(
                    'images/icons/transaction.png',
                    width: 22,
                    height: 22,
                  ),
                ),
                  const SizedBox(height: 4),
                  Text(
                    "Tickets",
                    style: GoogleFonts.lexend(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                    ),
                  ),
                  if (selectedTab == "Tickets")
                    Container(
                      width: 40,
                      height: 2,
                      color: Color(0xFF8CDDBB),
                    ),
                ],
              ),
            ),
            Positioned(
              left: containerWidth * 0.45,
              top: 16,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTabSelected("Home");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Image.asset(
                      'images/icons/home.png',
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Home",
                    style: GoogleFonts.lexend(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                    ),
                  ),
                  if (selectedTab == "Home")
                    Container(
                      width: 40,
                      height: 2,
                      color: Color(0xFF8CDDBB),
                    ),
                ],
              ),
            ),
            Positioned(
              left: containerWidth * 0.8,
              top: 16,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTabSelected("More");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MoreScreen()),
                      );
                    },
                    child: Image.asset(
                      'images/icons/mores.png',
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "More",
                    style: GoogleFonts.lexend(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                    ),
                  ),
                  if (selectedTab == "More")
                    Container(
                      width: 40,
                      height: 2,
                      color: Color(0xFF8CDDBB),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
