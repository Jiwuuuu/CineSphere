import 'package:cinesphere/main.dart';
import 'package:cinesphere/screens/home_screen.dart';
import 'package:cinesphere/screens/more.dart';
import 'package:cinesphere/screens/tickets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'images/Logo.png',
                  height: 50,
                ),
                const SizedBox(width: 10),
                Text(
                  "Why We Exist",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF39C55C),
                    fontSize: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset(
              'images/reasons.png',
              height: 470,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            _buildStorySection(),
            const SizedBox(height: 40),
            _buildTeamSection(),
            const SizedBox(height: 40),
            _buildFollowUsSection(),
            const SizedBox(height: 20),
            Divider(color: Colors.grey),
            const SizedBox(height: 20),
            _buildLegalLinks(),
            const SizedBox(height: 20),
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
      bottomNavigationBar: BottomNavBar(
        selectedTab: 'More',
        onTabSelected: (tab) {
          // Handle tab navigation here
        },
      ),
    );
  }


  Widget _buildFeatureTile(BuildContext context, String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 20,
            height: 20,
            color: Color(0xFF39C55C),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF39C55C),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                title,
                style: GoogleFonts.lexend(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our story",
          style: GoogleFonts.lexend(
            color: Color(0xFF39C55C),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildStoryTimeline("2024 - July", "Brainstorming", "The spark - This was the month where the idea for CineSphere was born. Brainstorming came from different team meetings and attempting to find innovative solutions for a seamless cinema experience."),
        const SizedBox(height: 20),
        _buildStoryTimeline("2024 - August to October", "Launch", "Bringing Cinema to Your Fingertips! The initial launch marked the start of CineSphere's journey to make cinema booking hassle-free."),
      ],
    );
  }

  Widget _buildStoryTimeline(String date, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Color(0xFF39C55C), size: 30),
            const SizedBox(width: 15),
            Text(
              date,
              style: GoogleFonts.lexend(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.lexend(
            color: Color(0xFF39C55C),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: GoogleFonts.lexend(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Team CineSphere",
          style: GoogleFonts.lexend(
            color: Color(0xFF39C55C),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildTeamMember("images/andrei.png", "Andrei Louise Amrinto", "Project Manager, Lead Designer, UI/UX Designer", "Responsible for technology and design, Andrei ensures CineSphere delivers a streamlined cinema experience."),
        const SizedBox(height: 20),
        _buildTeamMember("images/team/zyril.png", "Zyril James Salvador", "Assistant Developer", "Committed to writing efficient code and maintaining the app's functionality."),
        const SizedBox(height: 20),
        _buildTeamMember("images/team/jude.png", "Jude Cabrera", "Assistant Developer", "Plays a key role in developing and enhancing app features."),
      ],
    );
  }

  Widget _buildTeamMember(String imagePath, String name, String role, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 312,
          height: 312,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.lexend(
                  color: Color(0xFF39C55C),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                role,
                style: GoogleFonts.lexend(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: GoogleFonts.lexend(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFollowUsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Follow Us",
          style: GoogleFonts.lexend(
            color: Color(0xFF39C55C),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildSocialLink('images/icons/facebook.png', "Facebook"),
        const SizedBox(height: 15),
        _buildSocialLink('images/icons/instagram.png', "Instagram"),
        const SizedBox(height: 15),
        _buildSocialLink('images/icons/linkedin.png', "LinkedIn"),
      ],
    );
  }

  Widget _buildSocialLink(String iconPath, String platform) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        const SizedBox(width: 15),
        Text(
          platform,
          style: GoogleFonts.lexend(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildLegalLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            "Privacy Policy",
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Terms of Service",
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Cookies Settings",
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
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
