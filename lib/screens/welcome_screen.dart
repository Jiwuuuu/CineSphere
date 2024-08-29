import 'package:cinesphere/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/main.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;

  GradientText({
    required this.text,
    required this.gradient,
    this.style = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white), 
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/welcome.jpeg"),
            fit: BoxFit.cover,
        
            ),
        ),
         

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              text: "CS",
              gradient: LinearGradient(
                colors: [Color.fromRGBO(134, 162, 145, 100), Color.fromRGBO(177, 196, 185, 100) , Color.fromRGBO(78, 106, 89, 100)], 
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            GradientText(
              text: "CineSphere",
              gradient: LinearGradient(
                colors: [Color.fromRGBO(134, 162, 145, 100), Color.fromRGBO(177, 196, 185, 100) , Color.fromRGBO(78, 106, 89, 100)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: 30),
            Text("Book your Tickets Now!",
            style: TextStyle(
             color: text_color,
             fontSize: 20,
             fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: (){
                Navigator.push(context,
                 MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                decoration: BoxDecoration(
                  color: btn1_color,
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Get Started",
                style: TextStyle(
                  color: text_color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}