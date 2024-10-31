import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQsScreen extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {'question': 'What is CineSphere?', 'answer': 'CineSphere is an app to book movie tickets.'},
    {'question': 'How can I book a ticket?', 'answer': 'Select a movie, choose seats, and make a payment.'},
    {'question': 'How can I contact support?', 'answer': 'Use the Contact Us page for support options.'},
    {'question': 'Can I cancel my ticket after booking?', 'answer': 'Currently, ticket cancellations are not supported. Please contact support for assistance.'},
    {'question': 'Is there a mobile app for CineSphere?', 'answer': 'Yes, CineSphere is available as a mobile app for convenient ticket booking on the go.'},
    {'question': 'What payment methods are accepted?', 'answer': 'CineSphere accepts various payment methods, including credit/debit cards and popular digital wallets.'},
    {'question': 'Can I book tickets in advance?', 'answer': 'Yes, you can book tickets for upcoming movie screenings in advance.'},
    {'question': 'How do I know if my booking is confirmed?', 'answer': 'After successful payment, a booking confirmation will be shown, and your ticket details will appear in the Tickets section.'},
    {'question': 'What should I do if I encounter a payment issue?', 'answer': 'If you experience payment issues, please contact support for help resolving the problem.'},
    {'question': 'Can I choose my seats?', 'answer': 'Yes, CineSphere allows you to select available seats during the booking process.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
        backgroundColor: Color(0xFF07130E),
                iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      backgroundColor: Color(0xFF07130E),
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: faqs.length,
        separatorBuilder: (context, index) => Divider(
          color: Color(0xFF8CDDBB), // Customize the color of the divider
          thickness: 1.0,
        ),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            title: Text(
              faq['question']!,
              style: GoogleFonts.lexend(color: Color(0xFF8CDDBB), fontSize: 18),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  faq['answer']!,
                  style: GoogleFonts.lexend(color: Color(0xFFE2F1EB), fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
