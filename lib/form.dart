// src/presentation/form/screens/form_screen.dart
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _gender;
  String? _country;
  String? _state;
  String? _city;

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> countries = ['India', 'USA'];
  final Map<String, List<String>> states = {
    'India': ['Delhi', 'Maharashtra'],
    'USA': ['California', 'Texas']
  };
  final Map<String, List<String>> cities = {
    'Delhi': ['New Delhi'],
    'Maharashtra': ['Mumbai', 'Pune'],
    'California': ['Los Angeles', 'San Francisco'],
    'Texas': ['Houston', 'Dallas']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value != null && value.contains('@') ? null : 'Enter valid email',
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) => value != null && value.length == 10 ? null : 'Enter valid phone number',
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: _gender,
                items: genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => setState(() => _gender = val),
                validator: (value) => value == null ? 'Select gender' : null,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Country'),
                value: _country,
                items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setState(() {
                  _country = val;
                  _state = null;
                  _city = null;
                }),
                validator: (value) => value == null ? 'Select country' : null,
              ),
              if (_country != null)
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'State'),
                  value: _state,
                  items: states[_country]!.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) => setState(() {
                    _state = val;
                    _city = null;
                  }),
                  validator: (value) => value == null ? 'Select state' : null,
                ),
              if (_state != null)
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'City'),
                  value: _city,
                  items: cities[_state]!.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) => setState(() => _city = val),
                  validator: (value) => value == null ? 'Select city' : null,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form submitted successfully!')),
                    );
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
