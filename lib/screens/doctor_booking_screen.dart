import 'package:flutter/material.dart';

class DoctorBookingScreen extends StatelessWidget {
  const DoctorBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> doctors = [
      {
        "name": "Dr. Arjun Mehta",
        "specialty": "Endocrinologist",
        "experience": "12 years",
        "availability": "Mon - Fri, 10 AM - 5 PM"
      },
      {
        "name": "Dr. Priya Sharma",
        "specialty": "Diabetologist",
        "experience": "8 years",
        "availability": "Tue - Sat, 9 AM - 3 PM"
      },
      {
        "name": "Dr. Rohan Verma",
        "specialty": "General Physician",
        "experience": "10 years",
        "availability": "Mon - Fri, 11 AM - 6 PM"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book a Doctor"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor["name"]!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(doctor["specialty"]!,
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text("Experience: ${doctor["experience"]}"),
                  Text("Availability: ${doctor["availability"]}"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Appointment request sent to ${doctor["name"]}"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text("Book Appointment"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}