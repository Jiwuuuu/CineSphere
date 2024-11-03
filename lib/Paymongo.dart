import 'dart:convert';
import 'package:http/http.dart' as http;

class PayMongoService {
  final String secretKey = ''; // secret key

  // Function to create a payment link
  Future<String?> createPaymentLink({
    required String description,
    required int amount,
    required String currency,
  }) async {
    final url = Uri.parse('https://api.paymongo.com/v1/links');

    final headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('$secretKey:'))}',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'data': {
        'attributes': {
          'amount': amount,
          'description': description,
          'currency': currency,
        }
      }
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseData = json.decode(response.body);
      return responseData['data']['attributes']['checkout_url'];
    } else {
      print('Failed to create payment link: ${response.body}');
      return null;
    }
  }
}
