import 'package:cinesphere/booking_service.dart';
import 'package:cinesphere/database/local_storage_service.dart';
import 'package:cinesphere/database/supabase_service.dart'; // Added to connect to Supabase
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'paymongo.dart';
import 'dart:async'; // For using Future.delayed
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final supabaseClient = SupabaseService().client;

class PaymentSummaryScreen extends StatefulWidget {
  final String movieTitle;
  final String movieId;
  final DateTime date;
  final String format;
  final String scheduleTime;
  final List<String> seats;
  final int pricePerTicket;
  final String selectedCinemaSettingsId;
  final String selectedLocation;
  final List<Map<String, dynamic>> availableSeats;
  final Set<String> selectedSeats;

  PaymentSummaryScreen({
    required this.movieTitle,
    required this.movieId,
    required this.date,
    required this.format,
    required this.scheduleTime,
    required this.seats,
    required this.pricePerTicket,
    required this.selectedCinemaSettingsId,
    required this.selectedLocation,
    required this.availableSeats,
    required this.selectedSeats,
  });

  @override
  _PaymentSummaryScreenState createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  final PayMongoService _payMongoService = PayMongoService();
  final LocalStorageService _localStorageService = LocalStorageService();
  InAppWebViewController? webViewController;
  String? paymentUrl;

  int get totalAmount => widget.pricePerTicket * widget.seats.length;

  Future<void> createPayment() async {
    String? paymentLink = await _payMongoService.createPaymentLink(
      description: 'Payment for ${widget.movieTitle}',
      amount: totalAmount * 100, // Amount in centavos
      currency: 'PHP',
    );

    if (paymentLink != null) {
      setState(() {
        paymentUrl = paymentLink;
      });
    } else {
      print('Failed to generate payment link.');
    }
  }

Future<void> storeTransactionInDatabase(List<String> bookingIds, String localTransactionId) async {
  int retryCount = 0;
  const maxRetries = 5; // Max retries
  const delayDuration = Duration(seconds: 3); // Retry delay

  while (retryCount < maxRetries) {
    try {
      // Insert a transaction into the transactions table
      final response = await supabaseClient.from('transactions').insert({
        'movie_id': widget.movieId,
        'amount': totalAmount,
        'payment_status': 'Paid',
        'unique_code': localTransactionId, // Set the unique_code with the local transaction ID
      }).select();

      if (response.isNotEmpty) {
        String transactionId = response[0]['id'];

        // Insert each booking ID into the transaction_bookings table
        for (String bookingId in bookingIds) {
          await supabaseClient.from('transaction_bookings').insert({
            'transaction_id': transactionId,
            'booking_id': bookingId,
          });
        }

        print('Transaction and bookings stored successfully.');
        break;
      } else {
        print('Failed to retrieve transaction ID after insert.');
        retryCount++;
      }
    } catch (error) {
      print('Error storing transaction in database: $error');
      retryCount++;
      await Future.delayed(delayDuration);
    }
  }

  if (retryCount == maxRetries) {
    print('Failed to store transaction in database after $maxRetries attempts.');
  }
}

Future<void> onPaymentSuccess() async {
  final bookingService = BookingService();

  // Reserve seats and get booking IDs
  final bookingIds = await bookingService.reserveSeats(
    widget.selectedCinemaSettingsId,
    widget.movieId,
    widget.selectedLocation,
    widget.date,
    widget.format,
    widget.scheduleTime,
    widget.availableSeats,
    widget.selectedSeats,
  );

  // Ensure we have valid booking IDs
  if (bookingIds.isEmpty) {
    print('Failed to reserve seats. Cannot proceed with storing transaction.');
    return;
  }

  // Generate a local unique transaction ID
  String localTransactionId = DateTime.now().millisecondsSinceEpoch.toString();

  // Store the transaction in Supabase with the unique_code set to the local ID
  await storeTransactionInDatabase(bookingIds, localTransactionId);

  // Store transaction locally
  await _localStorageService.storeTransaction({
    'transaction_id': localTransactionId, // Local unique transaction ID
    'movie_title': widget.movieTitle,
    'movie_id': widget.movieId,
    'date': widget.date.toIso8601String(),
    'format': widget.format,
    'schedule_time': widget.scheduleTime,
    'seats': widget.seats,
    'amount': totalAmount,
    'payment_status': 'Paid',
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Payment successful! Seats reserved.')),
  );

  Navigator.of(context).pop();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF07130E), // Background color
      appBar: AppBar(
        backgroundColor: Color(0xFF07130E),
        title: Text(
          'Payment Summary',
          style: GoogleFonts.lexend(
            color: Color(0xFFE2F1EB), // Text color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: paymentUrl == null
          ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85, // Limit width
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF1F9060), // Container background for better contrast
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Limit container height
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Movie Title', widget.movieTitle),
                    _buildInfoRow(
                      'Date',
                      '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                    ),
                    _buildInfoRow('Format', widget.format),
                    _buildInfoRow('Schedule', widget.scheduleTime),
                    _buildInfoRow(
                      'Number of Tickets',
                      widget.seats.length.toString(),
                    ),
                    _buildInfoRow('Total Price', 'PHP $totalAmount'),
                    _buildInfoRow('Seats', widget.seats.join(', ')),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: createPayment,
                        child: const Text('Pay Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8CDDBB), // Primary color
                          foregroundColor: Color(0xFF07130E), // Button text color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          textStyle: GoogleFonts.lexend(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(paymentUrl!)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStop: (controller, url) async {
                if (url.toString().contains("success")) {
                  await onPaymentSuccess();
                }
              },
            ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE2F1EB), // Text color
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.lexend(
                fontSize: 18,
                color: Color(0xFFE2F1EB), // Text color
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
