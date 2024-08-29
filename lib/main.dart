import 'package:cinesphere/screens/welcome_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp(),);
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: ('Poppins'),
        scaffoldBackgroundColor: Color(0xFF212429),
      ),
      home: WelcomeScreen(),
    );
  }
}
