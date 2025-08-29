import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.1.29:3000/api'; // Replace with your backend URL
  static Map<String, dynamic>? loggedInUser;

  static Future<Map<String, dynamic>> register(String name, String username, String email, String password, String address) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'address': address,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      loggedInUser = data['user'];
      return data;
    } else {
      return jsonDecode(response.body);
    }
  }

  static Map<String, dynamic>? getLoggedInUser() {
    return loggedInUser;
  }

  static Future<Map<String, dynamic>> updateUser(String userId, String name, String email, String phone, String address) async {
    final body = {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
    print('Sending data to server: ${jsonEncode(body)}');

    final response = await http.put(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body.startsWith('{') || response.body.startsWith('[')) {
      try {
        return jsonDecode(response.body);
      } on FormatException catch (e) {
        print('Error decoding JSON: $e');
        return {'message': 'An error occurred while parsing the server response.'};
      }
    } else {
      return {'message': 'The server returned an invalid response.'};
    }
  }

  static Future<Map<String, dynamic>> addMoney(String accountNumber, String cardNumber, double amount, String cvv) async {
    // Simulate an API call for adding money
    // In a real app, this would be a secure call to a payment gateway
    print('Simulating add money API call...');
    print('Account Number: $accountNumber');
    print('Card Number: $cardNumber');
    print('Amount: $amount');
    print('CVV: $cvv');

    // Simulate a delay for network request
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success or failure
    if (amount > 0) {
      return {'success': true, 'message': 'Money added successfully!'};
    } else {
      return {'success': false, 'message': 'Failed to add money. Invalid amount.'};
    }
  }
}
