import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taskfive/data/api.dart';

class DemoService {
  static Future<Map<String, dynamic>> getData() async {
    var url = Uri.https(apiCall, '/api/v1');
    var response = await http.get(url);
    return response.headers;
  }
}
