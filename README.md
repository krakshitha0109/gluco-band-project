import 'package:flutter/material.dart';

void main() {
runApp(const GlucobandApp());
}

class GlucobandApp extends StatelessWidget {
const GlucobandApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Glucoband',
debugShowCheckedModeBanner: false,
theme: ThemeData(
primarySwatch: Colors.teal,
),
home: const SplashScreen(),
);
}
}

// Splash Screen
class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});

@override
State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
super.initState();
Future.delayed(const Duration(seconds: 3), () {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const LoginScreen()),
);
});
}

@override
Widget build(BuildContext context) {
return Container(
decoration: const BoxDecoration(
image: DecorationImage(
image: AssetImage("assets/images/background.png"),
fit: BoxFit.cover,
),
),
child: const Center(
child: Text(
"Glucoband",
style: TextStyle(
fontSize: 32,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
);
}
}

// Login Screen
class LoginScreen extends StatelessWidget {
const LoginScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
decoration: const BoxDecoration(
image: DecorationImage(
image: AssetImage("assets/images/background.png"),
fit: BoxFit.cover,
),
),
child: Center(
child: ElevatedButton(
onPressed: () {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const HomeScreen()),
);
},
child: const Text("Login"),
),
),
),
);
}
}

// Home Screen with Bottom Navigation
class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int _selectedIndex = 0;

final List<Widget> _pages = [
const GlucoseMonitorScreen(),
const HistoryScreen(),
const DoctorBookingScreen(),
const ChatScreen(),
];

void _onItemTapped(int index) {
setState(() {
_selectedIndex = index;
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: _pages[_selectedIndex],
bottomNavigationBar: BottomNavigationBar(
currentIndex: _selectedIndex,
onTap: _onItemTapped,
selectedItemColor: Colors.teal,
unselectedItemColor: Colors.grey,
items: const [
BottomNavigationBarItem(
icon: Icon(Icons.monitor_heart),
label: "Monitor",
),
BottomNavigationBarItem(
icon: Icon(Icons.history),
label: "History",
),
BottomNavigationBarItem(
icon: Icon(Icons.calendar_month),
label: "Book Doctor",
),
BottomNavigationBarItem(
icon: Icon(Icons.chat),
label: "Chat",
),
],
),
);
}
}

// Glucose Monitor Page
class GlucoseMonitorScreen extends StatelessWidget {
const GlucoseMonitorScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Glucose Monitor")),
body: const Center(child: Text("Live Glucose Data Here")),
);
}
}

// History Page
class HistoryScreen extends StatelessWidget {
const HistoryScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("History")),
body: const Center(child: Text("Past Readings List Here")),
);
}
}

// Doctor Booking Page
class DoctorBookingScreen extends StatelessWidget {
const DoctorBookingScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Book a Doctor")),
body: const Center(child: Text("Doctor Appointment Booking")),
);
}
}

// Chat Page
class ChatScreen extends StatelessWidget {
const ChatScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Chat with Doctor")),
body: const Center(child: Text("Chat Interface")),
);
}
}