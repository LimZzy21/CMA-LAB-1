import 'package:flutter/material.dart';
import 'profile_screen.dart'; 
import '../app_colors.dart'; 
import '../services/local_storage_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CategoriesScreen extends StatelessWidget {
  final List<String> categories = [
    'Electronics',
    'Fashion',
    'Home & Kitchen',
    'Books',
    'Toys',
    'Sports',
  ];

  final LocalStorageService _localStorageService = LocalStorageServiceImpl();

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _localStorageService.saveUserData('', '', '');
              Navigator.of(context).pop(); 
              Navigator.of(context).pop(); 
            },
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }

  void _listenToConnectivity(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You are offline. Some features may be limited.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listenToConnectivity(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Categories', style: TextStyle(color: AppColors.whiteColor)), 
        backgroundColor: AppColors.primaryColor, 
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.whiteColor), 
            onPressed: () => _showLogoutDialog(context), 
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            leading: Icon(Icons.category),
            onTap: () {

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        },
        child: Icon(Icons.person), 
        tooltip: 'Go to Profile',
      ),
    );
  }
}
