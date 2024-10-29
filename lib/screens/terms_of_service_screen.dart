import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class TermsOfServiceScreen extends StatefulWidget {
  @override
  _TermsOfServiceScreenState createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  late Future<void> _imageLoadingFuture;

  @override
  void initState() {
    super.initState();
    _imageLoadingFuture = _preloadImageWithDelay();
  }

  Future<void> _preloadImageWithDelay() async {
    // Preload the image so it's cached before displaying it, with a delay for the animation.
    await Future.delayed(Duration(seconds: 2)); // 2-second delay for animation
    await precacheImage(AssetImage('images/CineSphere - Mobile App - Terms of Service.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF07130E),
      body: FutureBuilder<void>(
        future: _imageLoadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show Lottie animation while waiting
            return Center(
              child: Lottie.asset(
                'assets/animations/loading_animation.json', // Path to your Lottie file
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error if image couldn't be loaded
            return Center(
              child: Text(
                'Error loading content. Please try again.',
                style: TextStyle(
                  color: Color(0xFF8CDDBB),
                  fontSize: 16,
                  fontFamily: 'Lexend',
                ),
              ),
            );
          } else {
            // Once loading is complete, show the image
            return SingleChildScrollView(
              child: Image.asset(
                'images/CineSphere - Mobile App - Terms of Service.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }
        },
      ),
    );
  }
}
