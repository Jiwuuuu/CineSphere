import 'package:flutter/material.dart';
import 'package:cinesphere/database/local_storage_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _transactions = [];
  late Future<void> _transactionsLoadingFuture;

  @override
  void initState() {
    super.initState();
    _transactionsLoadingFuture = _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      final transactions = await _localStorageService.getAllTransactions();
      final updatedTransactions = <Map<String, dynamic>>[];

      for (var transaction in transactions) {
        final localTransactionId = transaction['transaction_id'];
        final movieId = transaction['movie_id'];

        // Fetch movie details
        final movieResponse = await supabase
            .from('movies')
            .select()
            .eq('id', movieId)
            .single();

        // Fetch booking details; if multiple rows, handle accordingly
        final bookingResponse = await supabase
            .from('bookings')
            .select('location, screen_type')
            .eq('movie_id', movieId);

        if (movieResponse != null) {
          // Include additional details if fetched successfully
          transaction['movie_title'] = movieResponse['title'];
          transaction['genre'] = movieResponse['genre'];

          // Use only the first booking details, if available
          if (bookingResponse != null && bookingResponse.isNotEmpty) {
            transaction['location'] = bookingResponse[0]['location'] ?? 'N/A';
            transaction['screen_type'] = bookingResponse[0]['screen_type'] ?? 'Standard';
          } else {
            transaction['location'] = 'Unknown';
            transaction['screen_type'] = 'Standard';
          }
        }

        // Update unique_code if missing
        if (transaction['unique_code'] == null) {
          await supabase
              .from('transactions')
              .update({'unique_code': localTransactionId})
              .eq('unique_code', localTransactionId);

          transaction['unique_code'] = localTransactionId;
        }

        updatedTransactions.add(transaction);
      }

      setState(() {
        _transactions = updatedTransactions;
      });
    } catch (e) {
      print('Error in _loadTransactions: $e');
      setState(() {
        _transactionsLoadingFuture = Future.error(e);
      });
    }
  }

  Future<void> _clearAllTransactions() async {
    await _localStorageService.clearAllTransactions();
    setState(() {
      _transactions.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All tickets have been deleted.'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> _deleteTransaction(int index) async {
    final transaction = _transactions[index];
    await _localStorageService.deleteTransaction(transaction['transaction_id']);
    setState(() {
      _transactions.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ticket deleted successfully.'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF07130E),
        appBar: AppBar(
          backgroundColor: Color(0xFF07130E),
          title: Text(
            'My Tickets',
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_forever, color: Color(0xFFE2F1EB)),
              onPressed: () async {
                await _clearAllTransactions();
              },
              tooltip: 'Clear All Tickets',
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFE2F1EB)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<void>(
          future: _transactionsLoadingFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  'assets/animations/loading_animation.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading tickets. Please try again.',
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: _transactions.isEmpty
                    ? Center(
                        child: Text(
                          'No tickets found.',
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            color: Color(0xFFE2F1EB),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = _transactions[index];
                          final qrData = transaction['transaction_id'] + transaction['movie_title'];
                          final uniqueCode = transaction['unique_code'] ?? 'N/A';

                          return Card(
                            color: Color(0xFF1F9060),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction['movie_title'] ?? 'Unknown Title',
                                    style: GoogleFonts.lexend(
                                      fontSize: 22,
                                      color: Color(0xFFE2F1EB),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Genre: ${transaction['genre'] ?? 'N/A'}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Date: ${transaction['date']}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Location: ${transaction['location'] ?? 'Unknown'}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Screen Type: ${transaction['screen_type'] ?? 'Standard'}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Seats: ${transaction['seats'].join(', ')}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total: PHP ${transaction['amount']}',
                                        style: GoogleFonts.lexend(
                                          fontSize: 18,
                                          color: Color(0xFF40E49F),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () => _deleteTransaction(index),
                                        tooltip: 'Delete Ticket',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Unique Code: $uniqueCode',
                                    style: GoogleFonts.lexend(
                                      fontSize: 16,
                                      color: Color(0xFF8CDDBB),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Center(
                                    child: QrImageView(
                                      data: qrData,
                                      size: 150.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              );
            }
          },
        ),
      ),
    );
  }
}
