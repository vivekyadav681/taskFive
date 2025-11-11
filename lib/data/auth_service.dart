import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskfive/data/api.dart';

class AuthService {
  static Future<Map<String, dynamic>> signup({
    required String fullname,
    required String email,
    required String password,
    required String role,
  }) async {
    final url = Uri.https(baseURL, signupURL);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullname': fullname,
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
    }
    return data;
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.https(baseURL, loginURL);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
    }
    return data;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = Uri.https(baseURL, updatePasswordURL);
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: {'oldpassword': oldPassword, 'newpassword': newPassword},
    );

    return response.body;
  }
}
