import 'package:flutter/material.dart';
import 'background.dart'; // Make sure this import path is correct

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  SettingsScreen({required this.isDarkMode, required this.onThemeChanged});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _darkMode;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.isDarkMode;
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Background(
        child: ListView(
          children: [
            SwitchListTile(
              title: Text("Dark Mode"),
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
                widget.onThemeChanged(value);
              },
            ),
            SwitchListTile(
              title: Text("Enable Notifications"),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                // Future enhancement: toggle notifications
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}