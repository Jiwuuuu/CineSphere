import 'package:cinesphere/database/supabase_service.dart';
import 'package:cinesphere/main.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:flutter/material.dart';

final supabaseClient = SupabaseService().client;


class BookingScreen extends StatelessWidget {
  final Movie movie; // Add a field to hold the movie

  BookingScreen({required this.movie}); // Constructor with required parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for ${movie.title}'), // Display the movie title
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select your booking options',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the PaymentScreen when the button is pressed
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(), 
                  ),
                );
              },
              child: Text('Confirm Booking'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
