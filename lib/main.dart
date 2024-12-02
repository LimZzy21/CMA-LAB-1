import 'package:flutter/material.dart';
<<<<<<<<< Temporary merge branch 1
import 'screens/login_screen.dart';
import 'theme.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab 2',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          background: const Color.fromARGB(255, 186, 185, 185),
          onPrimary: AppColors.whiteColor,
          onSecondary: AppColors.textColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: TextTheme(
          displayLarge: TextStyle(color: AppColors.textColor, fontSize: 32, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: AppColors.textColor, fontSize: 16),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme: AppBarTheme(
          color: AppColors.primaryColor,
          titleTextStyle: TextStyle(color: AppColors.whiteColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: LoginScreen(),
=========

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Increment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IncrementHomePage(),
    );
  }
}

class IncrementHomePage extends StatefulWidget {
  const IncrementHomePage({Key? key}) : super(key: key);

  @override
  _IncrementHomePageState createState() => _IncrementHomePageState();
}

class _IncrementHomePageState extends State<IncrementHomePage> {
  int _counter = 0;
  final TextEditingController _controller = TextEditingController();
  String _message = '';

  // Метод для інкрементування лічильника на одиницю
  void _increment() {
    setState(() {
      _counter++;
      _message = 'Counter incremented by 1';
    });
  }

  // Метод для обробки введеного тексту
  void _incrementCounterByInput() {
    String inputText = _controller.text;

    // Перевірка, чи введений текст є числом
    if (int.tryParse(inputText) != null) {
      setState(() {
        _counter += int.parse(inputText);
        _message = 'Counter incremented by $inputText';
      });
    }
    // Перевірка на фразу "Avada Kedavra"
    else if (inputText.toLowerCase() == 'avada kedavra') {
      setState(() {
        _counter = 0;
        _message = 'Counter reset by spell!';
      });
    }
    // Перевірка на слово "pudge"
    else if (inputText.toLowerCase() == 'pudge') {
      setState(() {
        _counter = 1300;
        _message = 'Counter set to 1300 by pudge!';
      });
    }
    // Некоректне введення
    else {
      setState(() {
        _message = 'Please enter a valid number, "Avada Kedavra" or "pudge".';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Increment App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Counter Value: $_counter',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall, // Оновлений стиль
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _increment, // Збільшити на одиницю
                child: const Text('Increment by 1'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a number or a special word',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _incrementCounterByInput, // Обробити введений текст
                child: const Text('Submit Input'),
              ),
              const SizedBox(height: 20),
              Text(
                _message,
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
>>>>>>>>> Temporary merge branch 2
    );
  }
}
