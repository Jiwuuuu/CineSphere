import 'package:cinesphere/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/main.dart';


const start_color1 = Color(0xff86A291);
const start_color2 = Color(0xff4E6A59);
const start_color3 = Color(0xffB1C4B9);
const end_color1 = Color(0xffB1C4B9);
const end_color2 = Color(0xff4E6A59);
const end_color3 = Color(0xff86A291);

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final List<Color> startColors;
  final List<Color> endColors;
  final TextStyle style;

  const AnimatedGradientText({
    required this.text,
    required this.startColors,
    required this.endColors,
    this.style = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  });

  @override
  _AnimatedGradientTextState createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Color?>> _colorAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation forward and backward

    _colorAnimations = List<Animation<Color?>>.generate(
      widget.startColors.length,
      (index) => ColorTween(
        begin: widget.startColors[index],
        end: widget.endColors[index],
      ).animate(_controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: _colorAnimations.map((animation) => animation.value!).toList(),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WelcomeScreen extends StatelessWidget {
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
            AnimatedGradientText(
              text: "CS",
              startColors: [
                start_color1,
                start_color2,
                start_color3
              ],
              endColors: [
                end_color1,
                end_color2,
                end_color3
              ],
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedGradientText(
              text: "CineSphere",
              startColors: [
                start_color1,
                start_color2,
                start_color3
              ],
              endColors: [
                end_color1,
                end_color2,
                end_color3
              ],
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Book your Tickets Now!",
              style: TextStyle(
                color: text_color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  color: btn1_color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: text_color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
