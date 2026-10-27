import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class ApiService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message':
              data['message'] ?? 'Login failed. Please check credentials.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<bool> logout(String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      return response.statusCode == 200;
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return false;
    }
  }
}
