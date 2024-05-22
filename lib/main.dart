// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:html/parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerWidget(),
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  File? file;
  var result = "";

  Future<void> _pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        file = File(image!.path);
      });
      await classifyImage(file!);
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
  }

  Future classifyImage(File image) async {
    final uri = Uri.parse(
        'https://cat-dog-classifier-using-flask-xisi3zlsna-el.a.run.app/upload');

    var request = http.MultipartRequest('POST', uri);
    String mimeType = lookupMimeType(image.path) ?? 'application/octet-stream';
    var mimeTypeData = mimeType.split('/');
    request.files.add(await http.MultipartFile.fromPath(
      'photo',
      image.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      setState(() {
        result = responseBody;
      });
    } else {
      setState(() {
        result = 'Failed to upload image';
      });
    }
  }

  Future<void> _getPrediction(String endpoint) async {
    final uri = Uri.parse(
        'https://cat-dog-classifier-using-flask-xisi3zlsna-el.a.run.app/upload');

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        result = response.body;
      });
    } else {
      setState(() {
        result = 'Failed to retrieve prediction';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            title: Text('Cat or Dog Classifier'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () => _pickImage(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text('Select Image'),
            ),
          ),
          if (image != null)
            Container(
                padding: const EdgeInsets.all(20),
                child: Image.file(
                  File(image!.path),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ))
          else
            SizedBox(
              height: 240,
              child: Center(
                  child: Text(
                'No image selected',
                style: TextStyle(fontSize: 16),
              )),
            ),
          Padding(
            padding: const EdgeInsets.all(80),
            child: Text(
              parse(result).body?.text ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
