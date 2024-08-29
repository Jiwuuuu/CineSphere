import 'package:cinesphere/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
        style: style.copyWith(color: Colors.white), // Text color is set to white for gradient masking
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
          color: Colors.black,
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
                colors: [Color.fromARGB(255, 160, 221, 162), const Color.fromARGB(255, 3, 127, 228)], // Green to blue gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
            GradientText(
              text: "CineSphere",
              gradient: LinearGradient(
                colors: [const Color.fromARGB(255, 160, 221, 162), const Color.fromARGB(255, 3, 127, 228)], // Green to blue gradient
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
             color: Colors.white,
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
                  color: const Color.fromARGB(255, 88, 221, 108).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Get Started",
                style: TextStyle(
                  color: Colors.white,
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