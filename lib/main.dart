import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
void main() {
  runApp(const MyApp());  // Calls the runApp function to start the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfilePage(), // Set ProfilePage as the home screen
    );
  }
}
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  File? _selectedImage; // Store the selected image
  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  String _name = '';
  String _age = '';
  bool _isSubmitted = false; // Track whether the submit button is pressed

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // Function to pick the image from gallery
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Function to handle the Submit button press
  void _submit() {
    setState(() {
      _name = _nameController.text;
      _age = _ageController.text;
      _isSubmitted = true; // Mark as submitted
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField for Name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // TextField for Age
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Button to upload profile picture
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Profile Picture'),
            ),
            const SizedBox(height: 16),
            // Submit Button
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 16),
            // Display the entered Name and Age after submission
            if (_isSubmitted)
              Text('Name: $_name\nAge: $_age'),
            const SizedBox(height: 16),
            // Display the selected image or the placeholder icon after Submit
            if (_isSubmitted)
              _selectedImage != null
                  ? Center(
                      child: Image.file(
                        _selectedImage!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.account_circle,  // Placeholder icon
                        size: 150,
                        color: Colors.grey,     // You can customize the color
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
