// booking_service.dart
import 'package:cinesphere/database/supabase_service.dart';

final supabaseClient = SupabaseService().client;

class BookingService {
  Future<List<String>> reserveSeats(
    String cinemaSettingsId,
    String movieId,
    String? location,
    DateTime? date,
    String? screenType,
    String? scheduleTime,
    List<Map<String, dynamic>> availableSeats,
    Set<String> selectedSeats,
  ) async {
    List<String> bookingIds = [];
    try {
      for (String seatId in selectedSeats) {
        // Get seat details
        final seat = availableSeats.firstWhere((seat) => seat['id'] == seatId);

        // Insert a booking into the bookings table
        final response = await supabaseClient.from('bookings').insert({
          'movie_id': movieId,
          'location': location,
          'date': date?.toIso8601String(),
          'screen_type': screenType,
          'schedule_time': scheduleTime,
          'cinema_settings_id': cinemaSettingsId,
          'seat_id': seatId,
          'seat_number': seat['seat_number'], // Add seat_number to the booking
        }).select();

        // Only add the booking ID if it was successfully inserted
        if (response != null && response.isNotEmpty) {
          bookingIds.add(response[0]['id']);
        } else {
          print('Failed to insert booking for seat ID $seatId');
        }

        // Update the seat to mark it as booked
        await supabaseClient
            .from('seats')
            .update({'is_booked': true, 'last_updated': DateTime.now().toIso8601String()})
            .eq('id', seatId);
      }
    } catch (error) {
      print('Error reserving seats: $error');
    }
    return bookingIds;
  }
}
