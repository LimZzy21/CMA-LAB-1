import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AuthService {
  final String apiUrl = 'https://run.mocky.io/v3/1a75f82e-8573-40fc-bb94-2f1ffcd8e4f8';

  // Авторизація користувача через API
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Якщо API відповідає успішно
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        // Збереження токена
        String token = responseData['token'];
        await _saveToken(token);
        return true;
      }
    } else {
      // Якщо API повертає помилку
      print('Failed to login: ${response.statusCode}');
      return false;
    }
    return false;
  }

  // Збереження токена в SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Отримання токена з SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Вихід з системи та видалення токена
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
