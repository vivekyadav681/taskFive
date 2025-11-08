import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taskfive/data/api.dart';

class ForgotPasswordService {
  static Future<Map<String, dynamic>> sendResetLink(String email) async {
    try {
      final response = await http.post(
        Uri.https(apiCall, '/user/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to send reset link: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
