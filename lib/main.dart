import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'history.dart';
import 'doctorscreen.dart';
import 'setting.dart';
import 'home_screen.dart'; // Import the moved HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlucoBand',
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(
          isDarkMode: _isDarkMode,
          onThemeChanged: _toggleDarkMode,
        ),
        '/doctor': (context) => DoctorScreen(),
        '/history': (context) => HistoryScreen(),
        '/settings': (context) => SettingsScreen(
          isDarkMode: _isDarkMode,
          onThemeChanged: _toggleDarkMode,
        ),
      },
    );
  }
}