import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'Paymongo.dart'; // Your PayMongo service
import 'package:cinesphere/screens/welcome_screen.dart'; // Ensure this path is correct

const bg_color = Color(0xff0D110F);
const text_color = Color(0xffF6F9F7);
const primary_color = Color(0xff86A291);
const secondary_color = Color(0xff4E6A59);
const accent_color = Color(0xffB1C4B9);
const btn1_color = Color(0xff141F18);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xFF212429),
      ),
      home: WelcomeScreen(), // Change to your desired starting screen
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
