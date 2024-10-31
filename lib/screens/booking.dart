import 'package:cinesphere/database/supabase_service.dart';
import 'package:cinesphere/payment_summary.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final supabaseClient = SupabaseService().client;

class BookingScreen extends StatefulWidget {
  final Movie movie;

  BookingScreen({required this.movie});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final double ticketPrice = 450; // Price per ticket

  String? selectedCinemaSettingsId;
  String? selectedLocation;
  DateTime? selectedDate;
  String? selectedFormat;
  String? selectedTime;

  List<Map<String, String>> locations = [];
  List<String> locationNames = [];
  List<DateTime> availableDates = [];
  List<String> formats = [];
  List<String> times = [];
  List<Map<String, dynamic>> availableSeats = [];
  Set<String> selectedSeats = {}; // Track selected seat IDs

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      final response = await supabaseClient.from('cinema_locations').select();

      setState(() {
        locations = List<Map<String, String>>.from(response.map((location) => {
              'id': location['id'] as String,
              'name': location['name'] as String,
            }));

        locationNames = locations.map((location) => location['name']!).toList();
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching locations: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchAvailableDates(String locationId) async {
    setState(() {
      isLoading = true;
      selectedCinemaSettingsId = null;
      selectedFormat = null;
      selectedTime = null;
      availableDates.clear();
      formats.clear();
      times.clear();
      availableSeats.clear();
      selectedSeats.clear();
    });

    try {
      final response = await supabaseClient
          .from('cinema_settings')
          .select('available_date')
          .eq('location_id', locationId)
          .eq('movie_id', widget.movie.id);

      if (response.isNotEmpty) {
        setState(() {
          availableDates = response
              .map((setting) => DateTime.parse(setting['available_date']))
              .toSet()
              .toList();
        });
      } else {
        print('No available dates found for the selected location.');
      }
    } catch (error) {
      print('Error fetching available dates: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchSettings(String locationId, DateTime date) async {
    setState(() {
      isLoading = true;
      selectedCinemaSettingsId = null;
      selectedFormat = null;
      selectedTime = null;
      formats.clear();
      times.clear();
      availableSeats.clear();
      selectedSeats.clear();
    });

    try {
      final response = await supabaseClient
          .from('cinema_settings')
          .select()
          .eq('location_id', locationId)
          .eq('movie_id', widget.movie.id)
          .eq('available_date', date.toIso8601String().split('T').first);
          
      if (response.isNotEmpty) {
        setState(() {
          selectedCinemaSettingsId = response[0]['id'] as String;
          formats = response
              .map((setting) => setting['screen_type'] as String)
              .toSet()
              .toList();
          times = response
              .map((setting) => setting['schedule_time'].toString())
              .toSet()
              .toList();
        });
      } else {
        print('No settings found for the selected location and date.');
      }
    } catch (error) {
      print('Error fetching settings: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

Future<void> fetchAvailableSeats(String cinemaSettingsId) async {
  setState(() {
    isLoading = true;
    availableSeats.clear(); // Clear previous seats data
    selectedSeats.clear(); // Clear selected seats
  });

  try {
    final response = await supabaseClient
        .from('seats')
        .select()
        .eq('cinema_settings_id', cinemaSettingsId);

    setState(() {
      availableSeats = List<Map<String, dynamic>>.from(response);

      // Sort availableSeats by seat_number for consistent ordering
      availableSeats.sort((a, b) => a['seat_number'].compareTo(b['seat_number']));
    });
  } catch (error) {
    print('Error fetching available seats: $error');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
        backgroundColor: Color(0xFF07130E),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFE2F1EB)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Color(0xFF07130E),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Movie Title
                    Text(
                      widget.movie.title,
                      style: GoogleFonts.lexend(
                          fontSize: 28,
                          color: Color(0xFFE2F1EB),
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      dropdownColor: Color(0xFF07130E),
                      decoration: InputDecoration(
                        labelText: 'Location',
                        filled: true,
                        fillColor: Color(0xFF07130E),
                        labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                      ),
                      items: locationNames.map((locationName) {
                        return DropdownMenuItem(
                          value: locationName,
                          child: Text(locationName, style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                        );
                      }).toList(),
                      value: selectedLocation,
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
                          String? locationId = locations
                              .firstWhere((location) => location['name'] == value)['id'];
                          fetchAvailableDates(locationId!);
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    if (availableDates.isNotEmpty) ...[
                      DropdownButtonFormField<DateTime>(
                        dropdownColor: Color(0xFF07130E),
                        decoration: InputDecoration(
                          labelText: 'Available Dates',
                          filled: true,
                          fillColor: Color(0xFF07130E),
                          labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                        ),
                        items: availableDates.map((date) {
                          return DropdownMenuItem(
                            value: date,
                            child: Text(
                              DateFormat('MMMM d, yyyy').format(date), // Format as "Month Day, Year"
                              style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                            ),
                          );
                        }).toList(),
                        value: selectedDate,
                        onChanged: (value) {
                          setState(() {
                            selectedDate = value;
                            if (selectedLocation != null && selectedDate != null) {
                              String? locationId = locations
                                  .firstWhere((location) => location['name'] == selectedLocation)['id'];
                              fetchSettings(locationId!, selectedDate!);
                            }
                          });
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                    if (selectedCinemaSettingsId != null) ...[
                      DropdownButtonFormField<String>(
                        dropdownColor: Color(0xFF07130E),
                        decoration: InputDecoration(
                          labelText: 'Watch In',
                          filled: true,
                          fillColor: Color(0xFF07130E),
                          labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                        ),
                        items: formats.isNotEmpty
                            ? formats.map((format) {
                                return DropdownMenuItem(
                                    value: format,
                                    child: Text(format, style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))));
                              }).toList()
                            : null,
                        value: selectedFormat,
                        onChanged: formats.isNotEmpty
                            ? (value) => setState(() {
                                selectedFormat = value;
                              })
                            : null,
                      ),
                      SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          dropdownColor: Color(0xFF07130E),
                          decoration: InputDecoration(
                            labelText: 'Schedule',
                            filled: true,
                            fillColor: Color(0xFF07130E),
                            labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                          ),
                          items: selectedFormat != null && times.isNotEmpty // Only enable if 'Watch In' selected
                              ? times.map((time) {
                                  DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
                                  String formattedTime = DateFormat("h:mm a").format(parsedTime);

                                  return DropdownMenuItem(
                                    value: time,
                                    child: Text(
                                      formattedTime,
                                      style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                    ),
                                  );
                                }).toList()
                              : null,
                          value: selectedTime,
                          onChanged: selectedFormat != null && times.isNotEmpty
                              ? (value) {
                                  setState(() {
                                    selectedTime = value;
                                    if (selectedCinemaSettingsId != null) {
                                      fetchAvailableSeats(selectedCinemaSettingsId!);
                                    }
                                  });
                                }
                              : null,
                        ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text('Screen', style: GoogleFonts.lexend(fontSize: 16, color: Color(0xFFE2F1EB))),
                            SizedBox(height: 10),
                            ClipPath(
                              clipper: ArcClipper(),
                              child: Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width * 0.6,
                                color: Color(0xFFE2F1EB),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      if (availableSeats.isNotEmpty) ...[
                        Text('Select Available Seats', style: GoogleFonts.lexend(fontSize: 18, color: Color(0xFFE2F1EB))),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: availableSeats.map((seat) {
                            bool isSelected = selectedSeats.contains(seat['id']);
                            bool isBooked = seat['is_booked'] as bool;

                            return GestureDetector(
                              onTap: isBooked
                                  ? null // Disable tap if the seat is already booked
                                  : () {
                                      setState(() {
                                        if (isSelected) {
                                          selectedSeats.remove(seat['id']);
                                        } else {
                                          selectedSeats.add(seat['id']);
                                        }
                                      });
                                    },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.event_seat,
                                    size: 30,
                                    color: isBooked
                                        ? Colors.red // Booked seats are red
                                        : isSelected
                                            ? Color(0xFF8CDDBB) // Selected seats are greenish
                                            : Color(0xFFE2F1EB), // Available seats are white
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    seat['seat_number'],
                                    style: GoogleFonts.lexend(
                                      fontSize: 8,
                                      color: isBooked ? Colors.red : Color(0xFFE2F1EB),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: selectedSeats.isNotEmpty && selectedLocation != null && selectedDate != null &&
                                     selectedFormat != null && selectedTime != null
                              ? () async {
                                  List<String> selectedSeatNumbers = selectedSeats.map((seatId) {
                                    return availableSeats.firstWhere((seat) => seat['id'] == seatId)['seat_number'] as String;
                                  }).toList();

                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PaymentSummaryScreen(
                                        movieTitle: widget.movie.title,
                                        movieId: widget.movie.id,
                                        date: selectedDate!,
                                        format: selectedFormat!,
                                        scheduleTime: selectedTime!,
                                        seats: selectedSeatNumbers,
                                        pricePerTicket: widget.movie.price,
                                        selectedCinemaSettingsId: selectedCinemaSettingsId!,
                                        selectedLocation: selectedLocation!,
                                        availableSeats: availableSeats,
                                        selectedSeats: selectedSeats,
                                      ),
                                    ),
                                    );

                                  if (selectedCinemaSettingsId != null) {
                                    await fetchAvailableSeats(selectedCinemaSettingsId!);
                                  }
                                }
                              : null, // Disable if any required field is missing
                          child: Text('Proceed'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8CDDBB),
                            foregroundColor: Color(0xFF07130E),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
