import 'package:cinesphere/main.dart';
import 'package:cinesphere/screens/home_screen.dart';
import 'package:cinesphere/screens/more.dart';
import 'package:cinesphere/screens/tickets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: bg_color,
        elevation: 0,
        title: Text(
          "We Value Your Feedback!",
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            color: Color(0xFF39C55C),
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_nameController, "Your Name:"),
            const SizedBox(height: 20),
            _buildTextField(_roleController, "Role/Occupation: e.g., Software Developer"),
            const SizedBox(height: 20),
            _buildTextField(
              _feedbackController,
              "Feedback:",
              maxLines: 5,
            ),
            const SizedBox(height: 30),
            _buildRatingBar(),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _submitFeedback,
                icon: Image.asset(
                  'images/icons/rate.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  "Submit Feedback",
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF39C55C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedTab: 'More', onTabSelected: (tab) {}),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.lexend(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.lexend(
          color: Colors.grey,
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF39C55C)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF39C55C), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
          icon: Icon(
            Icons.star,
            color: index < _selectedRating ? Color(0xFF39C55C) : Colors.grey,
            size: 30,
          ),
        );
      }),
    );
  }

  void _submitFeedback() {
    // Handle the submission logic here
    print("Feedback Submitted:");
    print("Name: \${_nameController.text}");
    print("Role: \${_roleController.text}");
    print("Feedback: \${_feedbackController.text}");
    print("Rating: \$_selectedRating");
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
