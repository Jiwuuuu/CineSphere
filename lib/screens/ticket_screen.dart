import 'package:flutter/material.dart';
import 'package:cinesphere/database/local_storage_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();
  List<Map<String, dynamic>> _transactions = [];
  late Future<void> _transactionsLoadingFuture;

  @override
  void initState() {
    super.initState();
    _transactionsLoadingFuture = _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final transactions = await _localStorageService.getAllTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  Future<void> _clearAllTransactions() async {
    await _localStorageService.clearAllTransactions();
    setState(() {
      _transactions.clear(); // Clear the state to update the UI
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
        // Prevent the double back issue by ensuring we only pop the current route once.
        Navigator.pop(context);
        return false; // Return false to indicate we handled the pop manually.
      },
      child: Scaffold(
        backgroundColor: Color(0xFF07130E), // Background color
        appBar: AppBar(
          backgroundColor: Color(0xFF07130E),
          title: Text(
            'My Tickets',
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB), // Text color
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
                            color: Color(0xFFE2F1EB), // Text color
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = _transactions[index];
                          return Card(
                            color: Color(0xFF1F9060), // Secondary color for ticket cards
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
                                      color: Color(0xFFE2F1EB), // Text color
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Date: ${transaction['date']}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB), // Text color
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Format: ${transaction['format']}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB), // Text color
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Schedule: ${transaction['schedule_time']}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB), // Text color
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Seats: ${transaction['seats'].join(', ')}',
                                    style: GoogleFonts.lexend(
                                      color: Color(0xFFE2F1EB), // Text color
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
                                          color: Color(0xFF40E49F), // Accent color for total price
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent, // Delete icon color
                                        ),
                                        onPressed: () => _deleteTransaction(index),
                                        tooltip: 'Delete Ticket',
                                      ),
                                    ],
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
