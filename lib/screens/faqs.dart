import 'package:cinesphere/main.dart';
import 'package:cinesphere/screens/home_screen.dart';
import 'package:cinesphere/screens/more.dart';
import 'package:cinesphere/screens/tickets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: bg_color,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "FAQs",
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: Color(0xFF39C55C),
                fontSize: 32,
              ),
            ),
            Image.asset(
              'images/Logo.png',
              height: 50,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "( Frequently Asked Questions )",
              style: GoogleFonts.lexend(
                color: Color(0xFF39C55C),
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Find answers to the most common questions about CineSphere. If you need further assistance, feel free to reach out to our support team.",
              style: GoogleFonts.lexend(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildQuestionTile("Question text goes here");
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedTab: 'More', onTabSelected: (tab) {}),
    );
  }

  Widget _buildQuestionTile(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF39C55C),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          title: Text(
            question,
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF39C55C),
          ),
          onTap: () {
            // Handle tap to show answer
          },
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
