
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_payment/api/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'John Doe'); // Placeholder
  final _emailController = TextEditingController(text: 'john.doe@example.com'); // Placeholder
  final _phoneController = TextEditingController(text: '+1234567890'); // Placeholder
  final _addressController = TextEditingController(text: '123 Main St, Anytown, USA'); // Placeholder

  bool _isEditing = false;
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // TODO: Call API to save profile data
      // For now, just exit edit mode
      _toggleEdit();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6B8E23);
    const backgroundColor = Color(0xFFF5F5DC);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(Icons.person, size: 80, color: Colors.white)
                            : null,
                        backgroundColor: primaryColor,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: _pickImage,
                          style: IconButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    enabled: _isEditing,
                    validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    enabled: false, // Email is not editable
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    enabled: _isEditing,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    enabled: _isEditing,
                    validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
                  ),
                  const SizedBox(height: 32.0),
                  if (_isEditing)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Save', style: TextStyle(fontSize: 18.0)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
