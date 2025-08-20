import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GlucoseMonitorScreen extends StatefulWidget {
  const GlucoseMonitorScreen({super.key});

  @override
  State<GlucoseMonitorScreen> createState() => _GlucoseMonitorScreenState();
}

class _GlucoseMonitorScreenState extends State<GlucoseMonitorScreen> {
  double _bloodPressure = 0;
  double _glucoseValue = 0;
  bool _isLoading = false;

  //  Replace with your ThingSpeak details
  final String channelId = "3013676";
  final String readApiKey = "YWQBRJ8I400HC5F6";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final url =
        "https://api.thingspeak.com/channels/$channelId/feeds.json?api_key=$readApiKey&results=1";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final feeds = data["feeds"];
        if (feeds.isNotEmpty) {
          final latest = feeds[0];
          final bpValue = latest["field1"];
          final glucoseValue = latest["field2"];

          setState(() {
            _bloodPressure = double.tryParse(bpValue ?? "0") ?? 0;
            _glucoseValue = double.tryParse(glucoseValue ?? "0") ?? 0;
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Glucoband - Health Monitor"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchData,
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Live Health Readings",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Blood Pressure
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monitor_heart,
                    color: Colors.blue, size: 24),
                const SizedBox(width: 10),
                Text(
                  "Blood Pressure: $_bloodPressure mmHg",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: _bloodPressure > 140
                        ? Colors.red
                        : (_bloodPressure < 90
                        ? Colors.orange
                        : Colors.green),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Glucose
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bloodtype,
                    color: Colors.redAccent, size: 24),
                const SizedBox(width: 10),
                Text(
                  "Glucose: $_glucoseValue mg/dL",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: _glucoseValue > 140
                        ? Colors.red
                        : (_glucoseValue < 90
                        ? Colors.orange
                        : Colors.green),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _fetchData,
              icon: const Icon(Icons.sync),
              label: const Text("Refresh Data"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                textStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}