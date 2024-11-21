import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'app_colors.dart'; // Import your custom colors

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyAQJ9bBCW3-2HXfoiT79XzeXXvU5nP6zgI', 
    appId: "1:447889069427:android:07f2ce750e86bcf877e106",
     messagingSenderId: "447889069427",
      projectId: "lab-5-d5e13"
      ) );}
      else{
      await  Firebase.initializeApp();
      }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Store',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.textColor),
          bodyMedium: TextStyle(color: AppColors.textColor),
          displayLarge: TextStyle(color: AppColors.textColor),
          displayMedium: TextStyle(color: AppColors.textColor),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
