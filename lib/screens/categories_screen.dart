import 'package:flutter/material.dart';
import 'profile_screen.dart'; 
import '../app_colors.dart'; 
import '../services/local_storage_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/product.dart'; 
import '../services/fetch.dart';  
import 'ProductDetailScreen.dart';  // Імпортуємо екран деталей товару

class CategoriesScreen extends StatelessWidget {
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
        title: Text('Your Device', style: TextStyle(color: AppColors.whiteColor)),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.whiteColor),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),  // викликаємо метод для отримання товарів
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('${product.price} ${product.currency}'),
                  leading: product.imageUrl.isNotEmpty 
                      ? Image.network(product.imageUrl) 
                      : Icon(Icons.image),
                  trailing: Text('Rating: ${product.rating}'),
                  onTap: () {
                    // Перехід на екран з деталями товару
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            );
          }
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
