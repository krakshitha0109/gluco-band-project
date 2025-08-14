import 'package:flutter/material.dart';
import 'background.dart';
import 'chatscreen.dart'; // New file for chat per doctor

class DoctorScreen extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Anjali Patel',
      'specialization': 'Endocrinologist',
    },
    {
      'name': 'Dr. Ram Yadav',
      'specialization': 'Diabetologist',
    },
    {
      'name': 'Dr. Meera Iyer',
      'specialization': 'Nutrition Specialist',
    },
    {
      'name': 'Dr. Keshav Murty',
      'specialization': 'Internal Medicine',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consult a Doctor")),
      body: Background(
        child: ListView.builder(
          itemCount: doctors.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                title: Text(doctor['name']!),
                subtitle: Text(doctor['specialization']!),
                trailing: Wrap(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showBookingDialog(context, doctor['name']!);
                      },
                      child: Text("Book"),
                    ),
                    IconButton(
                      icon: Icon(Icons.chat),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(doctorName: doctor['name']!),
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

  void _showBookingDialog(BuildContext context, String doctorName) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );

    if (selectedDate == null) return; // Cancelled

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return; // Cancelled

    final appointmentDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Booking"),
        content: Text(
          "Book appointment with $doctorName on "
              "${appointmentDateTime.day}/${appointmentDateTime.month}/${appointmentDateTime.year} at "
              "${selectedTime.format(context)}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Appointment booked with $doctorName on ${appointmentDateTime.day}/${appointmentDateTime.month}/${appointmentDateTime.year} at ${selectedTime.format(context)}"),
                ),
              );
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }
}