import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../services/local_storage_service.dart'; // Correct import path
import 'registration_screen.dart';
import 'categories_screen.dart'; // Import for navigating to categories screen
import '../app_colors.dart'; // Import your colors

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalStorageService _localStorageService = LocalStorageServiceImpl(); // Use implementation

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final userData = await _localStorageService.getUserData(); // Asynchronous data retrieval
      if (userData != null &&
          userData['email'] == _emailController.text &&
          userData['password'] == _passwordController.text) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoriesScreen()), // Navigate to CategoriesScreen
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Неправильний email або пароль')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: AppColors.whiteColor)), // Set AppBar text color
        backgroundColor: AppColors.primaryColor, // Set AppBar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Form key for validation
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                labelText: 'Email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Введіть коректний email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                labelText: 'Пароль',
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть пароль';
                  }
                  if (value.length < 8) {
                    return 'Пароль має містити не менше 8 символів';
                  }
                  return null;
                },
              ),
              CustomButton(
                text: 'Login',
                onPressed: _loginUser, // Call asynchronous function
                backgroundColor: AppColors.primaryColor, // Set button background color
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                },
                child: Text('Не маєте аккаунта? Зареєструйтесь'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor, // Use background color
    );
  }
}
