import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinesphere/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xFF212429),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      if (isFirstTime) {
        await prefs.setBool('isFirstTime', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeManager()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class WelcomeManager extends StatefulWidget {
  @override
  _WelcomeManagerState createState() => _WelcomeManagerState();
}

class _WelcomeManagerState extends State<WelcomeManager> {
  int _currentScreen = 0;

  void _nextScreen() {
    if (_currentScreen < 2) {
      setState(() {
        _currentScreen++;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildWelcomeScreen()),
          _buildDots(),
          SizedBox(height: 10), // Reduced height here for closer placement
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    switch (_currentScreen) {
      case 0:
        return WelcomeScreen1(onNext: _nextScreen);
      case 1:
        return WelcomeScreen2(onNext: _nextScreen);
      case 2:
        return WelcomeScreen3(onNext: _nextScreen);
      default:
        return HomeScreen();
    }
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentScreen == index ? Color.fromARGB(255, 57, 197, 92) : Colors.grey,
          ),
        );
      }),
    );
  }
}

class WelcomeScreen1 extends StatelessWidget {
  final VoidCallback onNext;

  WelcomeScreen1({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/welcome.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 400), // Adjust this as needed
            Text("Welcome to", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            Text("CineSphere", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 57, 197, 92))),
            Text("Your go-to movie ticket app.", style: TextStyle(fontSize: 14, color: Colors.white)),
            Spacer(),
            ElevatedButton(
              onPressed: onNext,
              child: Text("Next", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 57, 197, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            SizedBox(height: 300), // Reduced space before the dots
          ],
        ),
      ],
    );
  }
}

class WelcomeScreen2 extends StatelessWidget {
  final VoidCallback onNext;

  WelcomeScreen2({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/The Nun II.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 400), // Adjust this as needed
            Text("Browse & Book Fast", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 57, 197, 92))),
            Text("Find movies, check times, book instantly.", style: TextStyle(fontSize: 14, color: Colors.white)),
            Spacer(),
            ElevatedButton(
              onPressed: onNext,
              child: Text("Next", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 57, 197, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            SizedBox(height: 300), // Reduced space before the dots
          ],
        ),
      ],
    );
  }
}

class WelcomeScreen3 extends StatelessWidget {
  final VoidCallback onNext;

  WelcomeScreen3({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Transformers One.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 450), // Adjust this as needed
            Text("Secure Payments", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 57, 197, 92))),
            Text("Pay quickly and safely.", style: TextStyle(fontSize: 14, color: Colors.white)),
            Spacer(),
            ElevatedButton(
              onPressed: onNext,
              child: Text("Get Started", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 57, 197, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            SizedBox(height: 300), // Reduced space before the dots
          ],
        ),
      ],
    );
  }
}