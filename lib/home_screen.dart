import 'package:flutter/material.dart';
import 'background.dart';
import 'history.dart';
import 'doctorscreen.dart';
import 'setting.dart';

class HomeScreen extends StatelessWidget {
  final int glucoseLevel = 110;
  final String status = "Normal";
  final String lastUpdated = "5 mins ago";

  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  HomeScreen({required this.isDarkMode, required this.onThemeChanged});

  final TextStyle headingTextStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GlucoBand"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Background(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.health_and_safety, size: 30, color: Colors.teal),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome to GlucoBand!\n",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text:
                            "DIABETES may be a daily battle, but we are warriors with infinite strength.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(Icons.monitor_heart, size: 40, color: Colors.teal),
                      const SizedBox(height: 10),
                      Text(
                        "$glucoseLevel mg/dL",
                        style: headingTextStyle.copyWith(fontSize: 36),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Status: $status",
                        style: headingTextStyle.copyWith(fontSize: 20, color: Colors.teal),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Last Updated: $lastUpdated",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _HomeButton(
                    icon: Icons.history_edu,
                    label: "History",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
                    },
                  ),
                  _HomeButton(
                    icon: Icons.medical_services,
                    label: "Doctor",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorScreen()));
                    },
                  ),
                  _HomeButton(
                    icon: Icons.settings,
                    label: "Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(
                            isDarkMode: isDarkMode,
                            onThemeChanged: onThemeChanged,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}