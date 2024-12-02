import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Ensure you import the ProfileScreen
import '../app_colors.dart'; // Import your colors

class CategoriesScreen extends StatelessWidget {
  final List<String> categories = [
    'Electronics',
    'Fashion',
    'Home & Kitchen',
    'Books',
    'Toys',
    'Sports',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Categories', style: TextStyle(color: AppColors.whiteColor)), // Set header text color
        backgroundColor: AppColors.primaryColor, // Set AppBar color
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            leading: Icon(Icons.category),
            onTap: () {
              // Action on category tap
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
        child: Icon(Icons.person), // Icon for the button
        tooltip: 'Go to Profile',
      ),
    );
  }
}
