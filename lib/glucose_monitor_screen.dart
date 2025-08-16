import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GlucoseMonitorScreen extends StatefulWidget {
  const GlucoseMonitorScreen({super.key});

  @override
  State<GlucoseMonitorScreen> createState() => _GlucoseMonitorScreenState();
}

class _GlucoseMonitorScreenState extends State<GlucoseMonitorScreen> {
  int _glucoseValue = 100; // default starting value
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Simulate live readings every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        // For now, generate random glucose values (80 - 180 mg/dL)
        _glucoseValue = 80 + Random().nextInt(100);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Glucose Monitoring"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Live Glucose Reading",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "$_glucoseValue mg/dL",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _glucoseValue > 140
                    ? Colors.red
                    : (_glucoseValue < 90 ? Colors.orange : Colors.green),
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
            const SizedBox(height: 10),
            const Text("Connected to Device"),
          ],
        ),
      ),
    );
  }
}