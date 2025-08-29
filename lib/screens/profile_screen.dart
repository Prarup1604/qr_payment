
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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String _originalName = '';
  String _originalEmail = '';
  String _originalPhone = '';
  String _originalAddress = '';

  bool _isEditing = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    final user = ApiService.getLoggedInUser();
    print('User data in ProfileScreen initState: $user'); // Debug print
    if (user != null) {
      _originalName = user['name'];
      _originalEmail = user['email'];
      _originalPhone = user['phone'] ?? '';
      _originalAddress = user['address'] ?? '';

      _nameController.text = _originalName;
      _emailController.text = _originalEmail;
      _phoneController.text = _originalPhone;
      _addressController.text = _originalAddress;
    }
  }

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
      if (!_isEditing) {
        _nameController.text = _originalName;
        _emailController.text = _originalEmail;
        _phoneController.text = _originalPhone;
        _addressController.text = _originalAddress;
      }
    });
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _nameController.text = _originalName;
      _emailController.text = _originalEmail;
      _phoneController.text = _originalPhone;
      _addressController.text = _originalAddress;
    });
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });

      // Show a loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        // In a real app, you would get the userId from your auth service
        const userId = "1"; 
        final result = await ApiService.updateUser(
          userId,
          _nameController.text,
          _emailController.text,
          _phoneController.text,
          _addressController.text,
        );

        if (mounted) {
          Navigator.of(context).pop(); // Hide loading indicator
          Navigator.of(context).pop(_image?.path);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Profile updated successfully!')),
          );
          setState(() {
            _originalName = _nameController.text;
            _originalEmail = _emailController.text;
            _originalPhone = _phoneController.text;
            _originalAddress = _addressController.text;

            // Update the loggedInUser in ApiService
            ApiService.loggedInUser?['name'] = _originalName;
            ApiService.loggedInUser?['email'] = _originalEmail;
            ApiService.loggedInUser?['phone'] = _originalPhone;
            ApiService.loggedInUser?['address'] = _originalAddress;
          });
        }
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop(); // Hide loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
          setState(() {
            _isEditing = true; // Re-enable editing if there was an error
          });
        }
      }
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
          _isEditing
              ? IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _saveProfile,
                )
              : IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _toggleEdit,
                ),
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: _cancelEdit,
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
                    enabled: _isEditing, 
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
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
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
