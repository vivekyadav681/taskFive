import 'dart:convert';
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

    Map<String, dynamic> data = {};
    try {
      data = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      data = {'message': response.reasonPhrase ?? 'Unknown response'};
    }

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      if (data['token'] != null) {
        await prefs.setString('token', data['token'].toString());
      }
      return {
        'statusCode': 200,
        'message': data['message'] ?? 'Login successful',
        ...data,
      };
    } else if (response.statusCode == 400) {
      return {
        'statusCode': 400,
        'message': data['message'] ?? data['error'] ?? 'Bad request',
      };
    } else if (response.statusCode == 401) {
      return {
        'statusCode': 401,
        'message': data['message'] ?? 'Unauthorized: invalid credentials',
      };
    } else if (response.statusCode == 404) {
      return {'statusCode': 404, 'message': data['message'] ?? 'Not found'};
    } else {
      return {
        'statusCode': response.statusCode,
        'message':
            data['message'] ??
            data['error'] ??
            response.reasonPhrase ??
            'Unexpected error',
      };
    }
  }

  static Future<String> logout(String email, String password) async {
    var url = Uri.https(baseURL, logoutURL);
    var response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    return jsonDecode(response.body);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String> updatePassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final url = Uri.https(baseURL, updatePasswordURL);
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'oldpassword': newPassword,
        'newpassword': confirmPassword,
      }),
    );

    return response.body;
  }

  static Future<String> verifyOTP(String email, String otp) async {
    var url = Uri.https(baseURL, otpURL);
    var response = await http.post(url, body: {"email": email, "otp": otp});
    return jsonEncode(response.body);
  }

  static Future<String> verifyResetOtp(String email, String otp) async {
    var url = Uri.https(baseURL, otpResetURL);
    var response = await http.post(url, body: {"email": email, "otp": otp});
    return jsonEncode(response.body);
  }

  static Future<String> forgotPassword(String email) async {
    var url = Uri.https(baseURL, forgotPasswordURL);
    var response = await http.post(url, body: {'email': email});
    return jsonDecode(response.body);
  }
}
