import 'package:cinesphere/screens/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinesphere/database/supabase_service.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  int starRating = 0;

  final supabaseClient = SupabaseService().client;

  // Submit feedback to the Supabase database
Future<void> submitFeedback() async {
  final name = nameController.text;
  final position = positionController.text;
  final feedback = feedbackController.text;
  final rating = starRating;

  if (name.isEmpty || feedback.isEmpty || rating == 0) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Please fill all required fields and provide a rating'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  try {
    await supabaseClient.from('feedback').insert({
      'name': name,
      'position': position,
      'feedback': feedback,
      'rating': rating,
    });

    // Navigate to ThankYouScreen on successful insert
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ThankYouScreen()),
    );
  } catch (error) {
    print('Error submitting feedback: $error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('An error occurred while submitting feedback.'),
      backgroundColor: Colors.red,
    ));
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
        backgroundColor: Color(0xFF07130E),
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      backgroundColor: Color(0xFF07130E),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Logo at the top of the form
              Image.asset(
                'images/Logo.png',
                height: 100,
              ),
              SizedBox(height: 20),
              // Name Input Field
              TextField(
                controller: nameController,
                style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                  filled: true,
                  fillColor: Color(0xFF8CDDBB).withOpacity(0.1),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8CDDBB), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Position Input Field
              TextField(
                controller: positionController,
                style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                decoration: InputDecoration(
                  labelText: 'Position/Job',
                  labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                  filled: true,
                  fillColor: Color(0xFF8CDDBB).withOpacity(0.1),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8CDDBB), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Feedback Input Field
              TextField(
                controller: feedbackController,
                maxLines: 4,
                style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                decoration: InputDecoration(
                  labelText: 'Feedback',
                  labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                  filled: true,
                  fillColor: Color(0xFF8CDDBB).withOpacity(0.1),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8CDDBB), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Star Rating
              Text('Star Rating', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < starRating ? Icons.star : Icons.star_border,
                      color: Color(0xFF8CDDBB),
                    ),
                    onPressed: () {
                      setState(() {
                        starRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitFeedback,
                child: Text('Submit Feedback'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8CDDBB),
                  foregroundColor: Color(0xFF07130E),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
