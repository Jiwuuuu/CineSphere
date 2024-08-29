import 'package:cinesphere/screens/welcome_screen.dart';
import 'package:flutter/material.dart';


const bg_color = Color(0xff0D110F);
const text_color = Color(0xffF6F9F7);
const primary_color = Color(0xff86A291);
const secondary_color = Color(0xff4E6A59);
const accent_color = Color(0xffB1C4B9);
const btn1_color = Color(0xff141F18);

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
