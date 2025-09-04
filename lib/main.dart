import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ Firebase core
import 'splash_screen.dart';
import 'login_screen.dart';
import 'history.dart';
import 'doctorscreen.dart';
import 'setting.dart';
import 'home_screen.dart';
import 'glucose_monitor_screen.dart';

// Ensure Firebase is initialized before app runs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Initialize Firebase
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
      theme: _isDarkMode
          ? ThemeData.dark()
          : ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(), // ✅ Firebase login will be here
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
        '/glucose': (context) => GlucoseMonitorScreen(),
      },
    );
  }
}