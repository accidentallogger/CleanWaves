import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _url = "http://10.0.2.2:3000/api/v1/auth";

  Future<String?> loginUser(String phone, String password) async {
    final res = await http.post(
      Uri.parse("$_url/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'password': password}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final token = data['token'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        return null;
      }
      return "Token missing in response.";
    } else {
      return "Login failed.";
    }
  }

  Future<String?> signupUser(Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse("$_url/signup"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (res.statusCode == 201) {
      return null;
    } else {
      return "Signup failed.";
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
