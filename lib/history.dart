import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'background.dart';

class HistoryScreen extends StatelessWidget {
  final List<FlSpot> glucoseData = [
    FlSpot(1, 100),
    FlSpot(2, 110),
    FlSpot(3, 95),
    FlSpot(4, 130),
    FlSpot(5, 115),
    FlSpot(6, 105),
    FlSpot(7, 125),
  ];

  final List<Map<String, dynamic>> readingList = [
    {'day': 'Day 1', 'value': 100},
    {'day': 'Day 2', 'value': 110},
    {'day': 'Day 3', 'value': 95},
    {'day': 'Day 4', 'value': 130},
    {'day': 'Day 5', 'value': 115},
    {'day': 'Day 6', 'value': 105},
    {'day': 'Day 7', 'value': 125},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Glucose History")),
      body: Background(
        child: SingleChildScrollView(
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
                            return Text(value.toInt().toString(),
                                style: TextStyle(fontSize: 10));
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text("Day ${value.toInt()}",
                                style: TextStyle(fontSize: 10));
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
              SizedBox(height: 24),
              Divider(),
              SizedBox(height: 12),
              Text("Recent Glucose Readings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: readingList.length,
                itemBuilder: (context, index) {
                  final reading = readingList[index];
                  return ListTile(
                    leading: Icon(Icons.bloodtype, color: Colors.red),
                    title: Text(reading['day']),
                    trailing: Text("${reading['value']} mg/dL"),
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