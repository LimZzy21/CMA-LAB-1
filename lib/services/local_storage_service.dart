import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> saveUserData(String email, String password, String name);
  Future<Map<String, String>?> getUserData();
}

class LocalStorageServiceImpl extends LocalStorageService {
  @override
  Future<void> saveUserData(String email, String password, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('name', name);
  }

  @override
  Future<Map<String, String>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final name = prefs.getString('name');

    if (email != null && password != null) {
      return {'email': email, 'password': password, 'name': name ?? ''};
    }
    return null;
  }
}
