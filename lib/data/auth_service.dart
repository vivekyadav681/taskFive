import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskfive/data/api.dart';

class AuthService {
  static Future<Map<String, dynamic>> signup({
    required String fullname,
    required String email,
    required String password,
    required String confirmpassword,
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
        'confirmpassword': confirmpassword,
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
      body: jsonEncode({
        'oldpassword': oldPassword,
        'newpassword': newPassword,
      }),
    );

    return response.body;
  }

  /// Fetch user data using the stored token
  static Future<Map<String, dynamic>> fetchUserData(String token) async {
    final url = Uri.https(baseURL, userProfileURL);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch user data: ${response.statusCode}');
    }
  }

  /// Check if a user exists by email
  /// Returns true if user exists, false if user is new (needs signup)
  /// Throws exception on network/server errors
  static Future<bool> checkUserExists(String email) async {
    try {
      final url = Uri.https(baseURL, checkUserURL);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Assumes API returns { 'exists': true/false } or similar
        return data['exists'] == true || data['user'] != null;
      } else if (response.statusCode == 404) {
        // User not found
        return false;
      } else {
        throw Exception('Error checking user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to check user existence: $e');
    }
  }


  static Future<bool> isNewUser(String email) async {
    final exists = await checkUserExists(email);
    return !exists;
  }

  static Future<String> verifyOTP(String email, String otp) async {
    var url = Uri.https(baseURL, otpURL);
    var response = await http.post(url, body: {"email": email, "otp": otp});
    return jsonEncode(response.body);
  }
}
