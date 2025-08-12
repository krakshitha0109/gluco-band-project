import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample glucose readings
    final List<Map<String, dynamic>> glucoseHistory = [
      {"date": "2025-08-01", "time": "08:00 AM", "level": 110},
      {"date": "2025-08-02", "time": "07:45 AM", "level": 145},
      {"date": "2025-08-03", "time": "08:10 AM", "level": 95},
      {"date": "2025-08-04", "time": "07:50 AM", "level": 180},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Glucose History"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/doc.jpg"), // background
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: glucoseHistory.length,
          itemBuilder: (context, index) {
            final reading = glucoseHistory[index];
            final int level = reading["level"];
            final Color statusColor = _getLevelColor(level);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor,
                    child: const Icon(Icons.water_drop, color: Colors.white),
                  ),
                  title: Text(
                    "$level mg/dL",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("${reading["date"]} • ${reading["time"]}"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getLevelColor(int level) {
    if (level < 100) return Colors.blue; // Low
    if (level <= 140) return Colors.green; // Normal
    return Colors.red; // High
  }
}