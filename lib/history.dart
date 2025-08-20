import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'background.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<FlSpot> glucoseData = [];
  List<Map<String, dynamic>> readingList = [];
  bool isLoading = true;

  // 🔑 Replace with your ThingSpeak Channel ID & Read API Key
  final String channelId = "3013676";
  final String apiKey = "YWQBRJ8I400HC5F6";

  @override
  void initState() {
    super.initState();
    fetchGlucoseHistory();
  }

  Future<void> fetchGlucoseHistory() async {
    final url =
        "https://api.thingspeak.com/channels/$channelId/fields/2.json?api_key=$apiKey&results=7";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final feeds = data["feeds"] as List;

        List<FlSpot> chartData = [];
        List<Map<String, dynamic>> listData = [];

        for (int i = 0; i < feeds.length; i++) {
          final feed = feeds[i];
          final glucose = double.tryParse(feed["field2"] ?? "0") ?? 0.0;
          final time = feed["created_at"] ?? "";

          // Add to chart (x = index+1, y = glucose value)
          chartData.add(FlSpot(i.toDouble() + 1, glucose));

          // Add to list
          listData.add({
            'day': "Reading ${i + 1}",
            'value': glucose,
            'time': time,
          });
        }

        setState(() {
          glucoseData = chartData;
          readingList = listData;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Glucose History")),
      body: Background(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 20,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text("R${value.toInt()}",
                                style: const TextStyle(fontSize: 10));
                          },
                          reservedSize: 32,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    gridData: FlGridData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: glucoseData,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.orangeAccent,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                "Recent Glucose Readings",
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blue),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: readingList.length,
                itemBuilder: (context, index) {
                  final reading = readingList[index];
                  return ListTile(
                    leading:
                    const Icon(Icons.bloodtype, color: Colors.red),
                    title: Text(reading['day']),
                    subtitle: Text("Time: ${reading['time']}"),
                    
                    trailing:
                    Text("${reading['value']} mg/dL"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}