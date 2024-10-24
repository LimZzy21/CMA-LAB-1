import 'package:flutter/material.dart';
import '../services/local_storage_service.dart'; // Correct import path
import '../app_colors.dart'; // Import your colors

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final LocalStorageService _localStorageService = LocalStorageServiceImpl();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      // Only proceed if the form is valid
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String name = _nameController.text;

      // Save user data locally
      await _localStorageService.saveUserData(email, password, name);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully!')),
      );

      // Navigate to login or other screen after registration
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: AppColors.whiteColor)), // Set AppBar text color
        backgroundColor: AppColors.primaryColor, // Set AppBar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Form key for validation
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
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
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
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
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка, введіть ваше ім’я';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('Register', style: TextStyle(color: AppColors.whiteColor)), // Set button text color
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // Use background color for the button
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor, // Use background color
    );
  }
}
