import 'package:flutter/material.dart';
import 'background.dart';
import 'chatscreen.dart';
import 'register_screen.dart';

class DoctorScreen extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Anjali Patel',
      'specialization': 'Endocrinologist',
      'availability': ['10:00 AM', '11:30 AM', '2:00 PM', '4:00 PM'],
    },
    {
      'name': 'Dr. Ram Yadav',
      'specialization': 'Diabetologist',
      'availability': ['9:00 AM', '12:00 PM', '3:30 PM', '6:00 PM'],
    },
    {
      'name': 'Dr. Meera Iyer',
      'specialization': 'Nutrition Specialist',
      'availability': ['10:30 AM', '1:00 PM', '5:00 PM'],
    },
    {
      'name': 'Dr. Keshav Murty',
      'specialization': 'Internal Medicine',
      'availability': ['9:30 AM', '11:00 AM', '2:30 PM', '5:30 PM'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consult a Doctor")),
      body: Background(
        child: ListView.builder(
          itemCount: doctors.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            final name = doctor['name'] as String;
            final spec = doctor['specialization'] as String;
            final availability = (doctor['availability'] as List).cast<String>();

            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(spec),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterScreen(
                              doctorName: name,
                              specialization: spec,
                              availability: availability,
                            ),
                          ),
                        );
                      },
                      child: const Text("Book"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat, color: Colors.teal),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(doctorName: name),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}