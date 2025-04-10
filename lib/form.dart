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

  final List<String> genders = ['Male', 'Female'];
  final List<String> countries = ['India', 'USA'];
  final Map<String, List<String>> states = {
    'India': ['Delhi', 'Maharashtra', 'West Bengal', 'Jharkhand', 'Bihar'],
    'USA': ['California', 'Texas']
  };
  final Map<String, List<String>> cities = {
    'Delhi': ['New Delhi'],
    'Maharashtra': ['Mumbai', 'Pune'],
    'West Bengal': ['Kolkata'],
    'Jharkhand': ['Ranchi'],
    'Bihar': ['Patna'],
    'California': ['Los Angeles', 'San Francisco'],
    'Texas': ['Houston', 'Dallas']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'User Form',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value != null && value.contains('@')
                    ? null
                    : 'Enter valid email',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value != null && value.length == 10
                    ? null
                    : 'Enter valid phone number',
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10),
                decoration: InputDecoration(
                  hintText: 'Gender',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: _gender,
                items: genders
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => _gender = val),
                validator: (value) => value == null ? 'Select gender' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'Country',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: _country,
                items: countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() {
                  _country = val;
                  _state = null;
                  _city = null;
                }),
                validator: (value) => value == null ? 'Select country' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              if (_country != null)
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'State',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: _state,
                  items: states[_country]!
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setState(() {
                    _state = val;
                    _city = null;
                  }),
                  validator: (value) => value == null ? 'Select state' : null,
                ),
              const SizedBox(
                height: 20,
              ),
              if (_state != null)
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'City',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: _city,
                  items: cities[_state]!
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) => setState(() => _city = val),
                  validator: (value) => value == null ? 'Select city' : null,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Form submitted successfully!'),
                      ),
                    );

                    setState(() {
                      _nameController.clear();
                      _emailController.clear();
                      _phoneController.clear();
                      _gender = null;
                      _country = null;
                      _state = null;
                      _city = null;
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
