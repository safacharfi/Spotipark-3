import 'dart:convert';
import 'dart:typed_data'; // Import for Uint8List
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html; // For web
import 'package:http/http.dart' as http;

class LicensePlateDetector extends StatefulWidget {
  @override
  _LicensePlateDetectorState createState() => _LicensePlateDetectorState();
}

class _LicensePlateDetectorState extends State<LicensePlateDetector> {
  final _picker = ImagePicker();
  Uint8List? _imageBytes;
  String _plateNumber = '';

  // Pick image from gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
      _detectPlate();
    }
  }

  // Send the image to the Flask API for plate detection
  Future<void> _detectPlate() async {
    final uri = Uri.parse('http://10.0.2.2:5000/detect-plate');

    if (_imageBytes == null) {
      setState(() {
        _plateNumber = 'No image selected';
      });
      return;
    }

    try {
      final request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          _imageBytes!,
          filename: 'uploaded_image.jpg',
        ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(responseBody);
        setState(() {
          _plateNumber = data['plate_number'] ?? 'No plate detected';
        });
      } else {
        setState(() {
          _plateNumber = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _plateNumber = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('License Plate Detection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detected Plate Number:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: TextEditingController(text: _plateNumber),
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Plate number will appear here...',
                prefixIcon: _imageBytes != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.memory(
                          _imageBytes!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
                suffixIcon: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _pickImage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
