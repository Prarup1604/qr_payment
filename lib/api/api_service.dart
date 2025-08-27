import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.0.133:3000/api'; // Replace with your backend URL

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

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateUser(String userId, String name, String phone, String address) async {
    // TODO: Implement the actual API call to update the user profile.
    // The backend for this is not yet implemented.
    print('Updating user $userId with name: $name, phone: $phone, address: $address');
    // Simulate a successful API call
    await Future.delayed(const Duration(seconds: 1));
    return {'message': 'Profile updated successfully'};
  }
}
