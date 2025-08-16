import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final String doctorName;
  final String specialization;
  final List<String> availability; // ✅ changed to List<String>

  RegisterScreen({
    required this.doctorName,
    required this.specialization,
    required this.availability,
  });

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _age = "";
  String _contact = "";
  String _symptoms = "";

  DateTime? _selectedDate;
  String? _selectedTime; // ✅ restrict time to available slots

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Booking Confirmed"),
          content: Text(
            "Patient: $_name\n"
                "Age: $_age\n"
                "Contact: $_contact\n"
                "Symptoms: $_symptoms\n\n"
                "Doctor: ${widget.doctorName}\n"
                "Specialization: ${widget.specialization}\n"
                "Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}\n"
                "Time: $_selectedTime",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please complete all details")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register - ${widget.doctorName}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Doctor: ${widget.doctorName}"),
              Text("Specialization: ${widget.specialization}"),
              SizedBox(height: 20),

              // Patient details
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter age" : null,
                onSaved: (value) => _age = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Contact Number"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Enter contact" : null,
                onSaved: (value) => _contact = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Symptoms / Reason"),
                onSaved: (value) => _symptoms = value ?? "",
              ),
              SizedBox(height: 20),

              // Date picker
              ElevatedButton(
                onPressed: _pickDate,
                child: Text(_selectedDate == null
                    ? "Pick Date"
                    : "Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"),
              ),

              // ✅ Dropdown for selecting available time
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Select Time"),
                value: _selectedTime,
                items: widget.availability
                    .map((time) =>
                    DropdownMenuItem(value: time, child: Text(time)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTime = value;
                  });
                },
                validator: (value) =>
                value == null ? "Please select a time slot" : null,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmBooking,
                child: Text("Confirm Booking"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}