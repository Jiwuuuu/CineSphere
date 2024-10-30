import 'package:flutter/material.dart';
import 'package:cinesphere/database/local_storage_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
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

      if (transaction['unique_code'] == null) {
        // Update Supabase with local transaction_id as unique_code, matching by unique_code instead of id
        await supabase
            .from('transactions')
            .update({'unique_code': localTransactionId})
            .eq('unique_code', localTransactionId); // Match using unique_code column

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

// Helper function to validate UUID format
bool _isValidUUID(String id) {
  final uuidRegex = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );
  return uuidRegex.hasMatch(id);
}

  String _generateUniqueCode() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(6, (index) => characters[random.nextInt(characters.length)]).join();
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
              onPressed: _clearAllTransactions,
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
                                    transaction['movie_title'],
                                    style: GoogleFonts.lexend(
                                      fontSize: 22,
                                      color: Color(0xFFE2F1EB),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Date: ${transaction['date']}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Format: ${transaction['format']}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Schedule: ${transaction['schedule_time']}',
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
                                  // Display the Unique Code
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