import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/local_storage_service.dart'; 
import '../app_colors.dart'; 
import 'registration_screen.dart'; 
import 'categories_screen.dart'; 

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LocalStorageService _localStorageService = LocalStorageServiceImpl();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    final userData = await _localStorageService.getUserData();

    if (userData != null && await _isConnected()) {
      _showNotificationDialog('Auto-login succeeded.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CategoriesScreen()),
      );
    } else if (userData != null) {
      _showNotificationDialog('Please connect to the network for auto-login.');
    }
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void _showNotificationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notification'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    if (!await _isConnected()) {
      _showNotificationDialog('No internet connection. Please try again.');
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await _authenticateUser(email, password);

    if (response != null && response['success'] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);

      _showNotificationDialog('Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CategoriesScreen()),
      );
    } else {
      _showNotificationDialog('Invalid email or password');
    }
  }

  Future<Map<String, dynamic>?> _authenticateUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://run.mocky.io/v3/21523da3-b753-4e3e-b760-d47915ce742b'),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // Перевірка наявності користувача
        if (responseBody['users'] != null) {
          // Пошук користувача з відповідним email
          final user = responseBody['users'].firstWhere(
            (user) => user['email'] == email && user['password'] == password,
            orElse: () => null,
          );

          if (user != null) {
            return {'success': true};  // Якщо користувач знайдений
          }
        }
        return {'success': false};  // Користувач не знайдений
      } else {
        print('Failed to authenticate user');
        return null;
      }
    } catch (e) {
      print('Error during authentication: $e');
      return null;
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('email');
              await prefs.remove('password');
              await prefs.remove('name');

              Navigator.of(context).pop();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: AppColors.whiteColor)),
        backgroundColor: AppColors.primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()),
              );
            },
            child: Text('Register', style: TextStyle(color: AppColors.whiteColor)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
