import 'package:flutter/material.dart';
// Ensure this path is correct
// Ensure this path is correct
import 'database/supabase_service.dart'; // Ensure this path is correct
import 'package:cinesphere/screens/splash_screen.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'Paymongo.dart';
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



