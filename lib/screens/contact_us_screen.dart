import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  // Method to launch email
  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'andr.amrinto.up@phinmaed.com',
      queryParameters: {'subject': 'Customer Support'},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  // Method to launch phone call
  void _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+639760237048',
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  // Method to launch GitHub
  void _launchGitHub() async {
    final Uri githubUri = Uri.parse('https://github.com/Jiwuuuu');
    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri);
    }
  }

  // Method to launch LinkedIn
  void _launchLinkedIn() async {
    final Uri linkedInUri = Uri.parse('https://www.linkedin.com/in/andrei-louise-amrinto-58b850288/');
    if (await canLaunchUrl(linkedInUri)) {
      await launchUrl(linkedInUri);
    }
  }

  // Method to launch Facebook
  void _launchFacebook() async {
    final Uri facebookUri = Uri.parse('https://www.facebook.com/profile.php?id=100008267345432');
    if (await canLaunchUrl(facebookUri)) {
      await launchUrl(facebookUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
        backgroundColor: Color(0xFF07130E),
          iconTheme: IconThemeData(
          color: Colors.white,
          )
      ),
      backgroundColor: Color(0xFF07130E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactOption('Email', 'andr.amrinto.up@phinmaed.com', Icons.email, _launchEmail),
            _buildContactOption('Phone', '+639760237048', Icons.phone, _launchPhone),
            _buildContactOption('GitHub', 'Jiwuuuu', Icons.code, _launchGitHub),
            _buildContactOption('LinkedIn', 'Andrei Louise Amrinto', Icons.business, _launchLinkedIn),
            _buildContactOption('Facebook', 'Andrei Amrinto', Icons.facebook, _launchFacebook),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(String title, String detail, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF8CDDBB)),
      title: Text(title, style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
      subtitle: Text(detail, style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
      onTap: onTap,
    );
  }
}
