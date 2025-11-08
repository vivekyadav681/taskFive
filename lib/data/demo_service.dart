import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taskfive/data/api.dart';

class DemoService {
  static Future<Map<String, dynamic>> getData() async {
    var url = Uri.https('job-seeking-app-1-5auy.onrender.com', '/api/v1');
    var response = await http.get(url);
    if (response.statusCode >= 400) throw Exception('unable to connect to API');
    return json.decode(response.body);
  }
}
