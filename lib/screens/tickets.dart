import 'package:cinesphere/screens/home_screen.dart';
import 'package:cinesphere/screens/more.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF07130E), // Dark background color matching Figma design
      body: Stack(
        children: [
          // Header and Ticket Icon
          Positioned(
            left: 30,
            top: 79,
            child: Text(
              "Ticket’s",
              style: GoogleFonts.lexend(
                color: Color(0xFF8CDDBB),
                fontSize: 35,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 39,
            child: Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/icons/ticket_icon.png'), // Update to match your asset
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          // No Booked Movies Message and Icon
          Positioned(
            left: 60,
            top: 335,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/icons/inbox_icon.png'), // Update to match your asset
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'You have not yet booked\nany movies.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    color: Color(0xFF8CDDBB),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Navigation Bar
          Positioned(
            bottom: 20,
            left: 30,
            right: 30,
            child: BottomNavBar(
              selectedTab: 'Tickets',
              onTabSelected: (String tab) {
                if (tab == 'Home') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else if (tab == 'More') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MoreScreen()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// BottomNavBar widget for navigation
class BottomNavBar extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;

  const BottomNavBar({
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

    return Container(
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
      child: Stack(
        children: [
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
                    color: Colors.white,
                    fontSize: 8,
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
                  onTap: () => onTabSelected("Home"),
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
                    color: Colors.white,
                    fontSize: 8,
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
                  onTap: () => onTabSelected("More"),
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
                    color: Colors.white,
                    fontSize: 8,
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
    );
  }
}
