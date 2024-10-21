import 'package:table_calendar/table_calendar.dart';
import 'package:cinesphere/database/supabase_service.dart';
import 'package:cinesphere/main.dart';
import 'package:cinesphere/screens/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final supabaseClient = SupabaseService().client;

class BookingScreen extends StatefulWidget {
  final Movie movie;

  BookingScreen({required this.movie});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final int maxSeats = 6; // Maximum number of seats user can select
  final double ticketPrice = 450; // Price per ticket

  List<String> selectedSeats = []; // List to store selected seat indices (now Strings)
  List<String> bookedSeats = []; // List to store booked seats from database (now Strings)
  List<String> seatNumbers = []; // List to store all seat numbers fetched from the database

  String? selectedCinemaSettingsId; // To store the selected cinema settings ID


  // Dropdown selections
  String? selectedLocation;
  String? selectedFormat;
  String? selectedTime;

  List<Map<String, String>> locations = []; // List to store fetched locations with UUID and name
  List<String> locationNames = []; // List of location names for dropdown
  List<DateTime> availableDates = []; // List to store fetched available dates
  List<String> formats = []; // List to store fetched formats
  List<String> times = []; // List to store fetched times

  bool isLoading = true; // State to manage loading indicator
  DateTime? selectedDate; // Selected date for booking

  @override
  void initState() {
    super.initState();
    fetchLocations(); // Fetch cinema locations when screen initializes
  }

  Future<void> fetchLocations() async {
    try {
      final response = await supabaseClient
          .from('cinema_locations')
          .select();

      setState(() {
        locations = List<Map<String, String>>.from(response.map((location) => {
              'id': location['id'] as String,
              'name': location['name'] as String,
            }));

        // Extract location names for dropdown options
        locationNames = locations.map((location) => location['name']!).toList();

        isLoading = false; // Stop loading after fetching locations
      });
    } catch (error) {
      // Handle error (optional: show a message or log the error)
      print('Error fetching locations: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

Future<void> fetchSettings(String locationId) async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await supabaseClient
        .from('cinema_settings')
        .select()
        .eq('location_id', locationId)
        .eq('movie_id', widget.movie.id);

    if (response.isNotEmpty) {
      // Store the ID of the first available setting for the selected location and movie
      selectedCinemaSettingsId = response[0]['id'] as String;

      setState(() {
        availableDates = response
            .map((setting) => DateTime.parse(setting['available_date']))
            .toSet()
            .toList();
        formats = response
            .map((setting) => setting['screen_type'] as String)
            .toSet()
            .toList();
        times = response
            .map((setting) => setting['schedule_time'].toString())
            .toSet()
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('No settings found for the selected location.');
    }
  } catch (error) {
    setState(() {
      isLoading = false;
    });
    print('Error fetching settings: $error');
  }
}


Future<void> fetchSeatAvailability(String cinemaSettingsId) async {
  try {
    final response = await supabaseClient
        .from('seat_availability')
        .select()
        .eq('cinema_settings_id', cinemaSettingsId);

    setState(() {
      bookedSeats = [];
      if (response.isNotEmpty) {
        for (var seat in response) {
          String seatNumber = seat['seat_number'].toString();
          if (seat['is_booked'] == true) {
            bookedSeats.add(seatNumber);
          }
        }
      } else {
        print('No seats found for the selected schedule.');
      }
      isLoading = false;
    });
  } catch (error) {
    print('Error fetching seat availability: $error');
    setState(() {
      isLoading = false;
    });
  }
}



Future<void> reserveSeats(String cinemaSettingsId) async {
  try {
    for (String seatNumber in selectedSeats) {
      print('Reserving seat: $seatNumber'); // Debug statement

      final response = await supabaseClient
          .from('seat_availability')
          .update({'is_booked': true})
          .eq('cinema_settings_id', cinemaSettingsId)
          .eq('seat_number', seatNumber)
          .select();

      if (response.isEmpty) {
        throw 'Error updating seat $seatNumber for cinema settings $cinemaSettingsId';
      }

      print('Update Response: $response'); // Debug statement
    }

    setState(() {
      bookedSeats.addAll(selectedSeats); // Add the selected seats to bookedSeats
      selectedSeats.clear(); // Clear selected seats after reservation
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Seats reserved successfully!')),
    );
  } catch (error) {
    print('Error reserving seats: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to reserve seats. Please try again.')),
    );
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
                      widget.movie.title, // Dynamically displaying the movie title
                      style: GoogleFonts.lexend(
                          fontSize: 28,
                          color: Color(0xFFE2F1EB),
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 10),
                    // Screen Label
                    Text(
                      'Screen',
                      style: GoogleFonts.lexend(fontSize: 14, color: Color(0xFFE2F1EB)),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      'images/icons/Screen.png',
                      width: 350,
                      height: 30,
                    ),
                    SizedBox(height: 20),
                    // Seat Grid with walkway
                    Container(
  height: 400,
  width: double.infinity,
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 11, // 10 seats + 1 walkway
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    ),
    itemCount: 55, // Number of seats (e.g., 50 seats + 5 walkway spaces)
    itemBuilder: (context, index) {
      if ((index + 1) % 11 == 6) {
        // Create empty space for walkway
        return Container();
      }
      String seatNumber = ((index ~/ 11) * 10 + (index % 11 >= 6 ? index % 11 - 1 : index % 11) + 1).toString();
      bool isSelected = selectedSeats.contains(seatNumber);
      bool isBooked = bookedSeats.contains(seatNumber);

      return GestureDetector(
        onTap: () {
          if (!isBooked) {
            setState(() {
              if (isSelected) {
                selectedSeats.remove(seatNumber); // Deselect seat
              } else if (selectedSeats.length < maxSeats) {
                selectedSeats.add(seatNumber); // Select seat
              }
            });
          }
        },
        child: Icon(
          Icons.event_seat,
          color: isBooked
              ? Colors.red // Booked seats will be red
              : isSelected
                  ? Color(0xff40E49F) // Selected seats
                  : Colors.grey[800], // Available seats
          size: 30,
        ),
      );
    },
  ),
),

                    SizedBox(height: 20), // Spacing between seat grid and dropdowns
                    // Location Dropdown
                    DropdownButtonFormField<String>(
                      dropdownColor: Color(0xFF07130E),
                      decoration: InputDecoration(
                        labelText: 'Location',
                        filled: true,
                        fillColor: Color(0xFF07130E),
                        labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)), // Change the label color here
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
                          // Find the UUID for the selected location name
                          String? locationId = locations
                              .firstWhere((location) => location['name'] == value)['id'];

                          // Fetch settings for the selected location UUID
                          fetchSettings(locationId!);
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    if (selectedLocation != null) ...[
                      // Updated Calendar Widget for Dates
                      Text(
                        'Select Available Date',
                        style: GoogleFonts.lexend(fontSize: 18, color: Color(0xFFE2F1EB)),
                      ),
                      TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(Duration(days: 365)),
                        focusedDay: selectedDate ?? DateTime.now(),
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month',
                        },
                        headerStyle: HeaderStyle(
                          titleTextStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB), fontSize: 20),
                          formatButtonVisible: false,
                          leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFFE2F1EB)),
                          rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFFE2F1EB)),
                        ),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            if (availableDates.any((availableDate) => isSameDay(availableDate, day))) {
                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF40E49F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '${day.day}',
                                    style: GoogleFonts.lexend(color: Colors.white),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Text('${day.day}'),
                              );
                            }
                          },
                        ),
                        selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          if (availableDates.any((availableDate) => isSameDay(availableDate, selectedDay))) {
                            setState(() {
                              selectedDate = selectedDay; // Properly assign selectedDay as DateTime
                            });
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      // Format Dropdown
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
                            ? (value) => setState(() => selectedFormat = value)
                            : null,
                      ),
                      SizedBox(height: 10),
                      // Schedule Dropdown
                      DropdownButtonFormField<String>(
                        dropdownColor: Color(0xFF07130E),
                        decoration: InputDecoration(
                          labelText: 'Schedule',
                          filled: true,
                          fillColor: Color(0xFF07130E),
                          labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                        ),
                        items: times.isNotEmpty
                            ? times.map((time) {
                                return DropdownMenuItem(
                                    value: time,
                                    child: Text(time, style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))));
                              }).toList()
                            : null,
                        value: selectedTime,
                        onChanged: times.isNotEmpty
                            ? (value) => setState(() => selectedTime = value)
                            : null,
                      ),

                      SizedBox(height: 10),
                      Text(
                        "Total Price: ₱\${(selectedSeats.length * ticketPrice).toStringAsFixed(2)}",
                        style: GoogleFonts.lexend(fontSize: 20, color: Color(0xFFE2F1EB)),
                      ),

                      SizedBox(height: 10),
ElevatedButton(
  onPressed: (selectedLocation != null &&
              selectedDate != null &&
              selectedFormat != null &&
              selectedTime != null &&
              selectedSeats.isNotEmpty &&
              selectedCinemaSettingsId != null) // Make sure cinemaSettingsId is not null
      ? () {
          reserveSeats(selectedCinemaSettingsId!); // Pass the selected cinemaSettingsId
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentScreen(),
            ),
          );
        }
      : null,
  child: Text('Proceed'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF8CDDBB),
    foregroundColor: Color(0xFF07130E),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  ),
),

                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
