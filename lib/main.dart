import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinesphere/screens/home_screen.dart'; // Import your HomeScreen

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
    switch (_currentScreen) {
      case 0:
        return WelcomeScreen1(onNext: _nextScreen);
      case 1:
        return WelcomeScreen2(onNext: _nextScreen);
      case 2:
        return WelcomeScreen3(onNext: _nextScreen);
      default:
        return HomeScreen(); // Fallback
    }
  }
}

class WelcomeScreen1 extends StatelessWidget {
  final VoidCallback onNext;

  WelcomeScreen1({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/welcome.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to", style: TextStyle(fontSize: 24, color: Colors.white)),
              Text("CineSphere", style: TextStyle(fontSize: 30, color: const Color.fromARGB(255, 57, 197, 92))),
              Text("Your go-to movie ticket app.", style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(height: 20),
              ElevatedButton(onPressed: onNext, child: Text("Next")),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen2 extends StatelessWidget {
  final VoidCallback onNext;

  WelcomeScreen2({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/The Nun II.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Browse & Book Fast", style: TextStyle(fontSize: 24, color: Colors.white)),
              Text("Find movies, check times, book instantly.", style: TextStyle(fontSize: 24, color: Colors.white)),
              SizedBox(height: 20),
              ElevatedButton(onPressed: onNext, child: Text("Next")),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen3 extends StatelessWidget {
  final VoidCallback onNext;

  WelcomeScreen3({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Transformers One.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Secure Payments", style: TextStyle(fontSize: 24, color: Colors.white)),
              Text("Pay quickly and safely.", style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(height: 20),
              ElevatedButton(onPressed: onNext, child: Text("Get Started")),
            ],
          ),
        ),
      ),
    );
  }
}