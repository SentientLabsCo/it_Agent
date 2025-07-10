import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Use platform-specific localhost addressing
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5000'; // Android emulator localhost
    } else if (Platform.isIOS) {
      return 'http://localhost:5000'; // iOS simulator
    } else {
      return 'http://localhost:5000'; // Desktop platforms (Windows, macOS, Linux)
    }
  }
  
  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'message': message,
        }),
      ).timeout(const Duration(seconds: 30)); // Increased timeout for slower connections

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? 'No response received';
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? 'Failed to get response from server (${response.statusCode})');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network connection error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid response format: ${e.message}');
    } on Exception catch (e) {
      if (e.toString().contains('Connection refused') || 
          e.toString().contains('Failed to connect')) {
        throw Exception('Cannot connect to server. Make sure the backend is running on ${baseUrl.replaceAll('http://', '')}');
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }

  static Future<bool> checkServerConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/health'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'healthy';
      }
      return false;
    } on http.ClientException catch (e) {
      print('Connection check failed (ClientException): ${e.message}');
      return false;
    } on FormatException catch (e) {
      print('Connection check failed (FormatException): ${e.message}');
      return false;
    } catch (e) {
      print('Connection check failed: ${e.toString()}');
      return false;
    }
  }
}
