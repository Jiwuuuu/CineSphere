import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinesphere/screens/home_screen.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'Paymongo.dart';
import 'database/supabase_service.dart'; // Your PayMongo service

// Colors
const bg_color = Color(0xff07130E);
const text = Color(0xffE2F1EB);
const header_text = Color(0xff40E49F);
const icon_color = Color(0xff8CDDBB);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseService().initializeSupabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF212429),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
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

    return const Scaffold(
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
          const SizedBox(height: 10), // Reduced height here for closer placement
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
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentScreen == index ? const Color.fromARGB(255, 57, 197, 92) : Colors.grey,
          ),
        );
      }),
    );
  }
}

// PaymentScreen class
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PayMongoService _payMongoService = PayMongoService();
  InAppWebViewController? webViewController;
  String? paymentUrl;

  Future<void> createPayment() async {
    String? paymentLink = await _payMongoService.createPaymentLink(
      description: 'Movie Ticket',
      amount: 50000, // 500 PHP in centavos
      currency: 'PHP',
    );

    if (paymentLink != null) {
      setState(() {
        paymentUrl = paymentLink; // Store the payment link
      });
    } else {
      print('Failed to generate payment link.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Payment'),
      ),
      body: paymentUrl == null
          ? Center(
              child: ElevatedButton(
                onPressed: createPayment,
                child: const Text('Pay Now'),
              ),
            )
          : InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(paymentUrl!)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
            ),
    );
  }
}

// Welcome screens remain the same
class WelcomeScreen1 extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomeScreen1({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
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
            const SizedBox(height: 400), // Adjust this as needed
            const Text("Welcome to",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const Text("CineSphere",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 57, 197, 92))),
            const Text("Your go-to movie ticket app.",
                style: TextStyle(fontSize: 14, color: Colors.white)),
            const Spacer(),
            ElevatedButton(
              onPressed: onNext,
              child: const Text("Next", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 57, 197, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            const SizedBox(height: 300), // Reduced space before the dots
          ],
        ),
      ],
    );
  }
}

class WelcomeScreen2 extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomeScreen2({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
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
            const SizedBox(height: 400), // Adjust this as needed
            const Text("Browse & Book Fast",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 57, 197, 92))),
            const Text("Find movies, check times, book instantly.",
                style: TextStyle(fontSize: 14, color: Colors.white)),
            const Spacer(),
            ElevatedButton(
              onPressed: onNext,
              child: const Text("Next", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 57, 197, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            const SizedBox(height: 300), // Reduced space before the dots
          ],
        ),
      ],
    );
  }
}

class WelcomeScreen3 extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomeScreen3({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Osaka.jpeg'),
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
            const SizedBox(height: 400), // Adjust this as needed
            const Text("Secure Payments",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 57, 197, 92))),
            const Text("Pay safely with various methods.",
                style: TextStyle(fontSize: 14, color: Colors.white)),
            const Spacer(),
            ElevatedButton(
              onPressed: onNext,
              child: const Text("Get Started", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 57, 197, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            const SizedBox(height: 300), // Reduced space before the dots
          ],
        ),
      ],
    );
  }
}
