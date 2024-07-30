import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelection extends StatefulWidget {
  const ImageSelection({super.key});

  @override
  _ImageSelectionState createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _takeImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedImage != null)
              Stack(
                children: [
                  Image.file(
                    File(_selectedImage!.path),
                    fit: BoxFit.fitWidth,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: const Icon(Icons.close), onPressed: _clearImage,
                    )
                  )
                ],
              )
            else
              Column(
                children: <Widget>[ElevatedButton(
                  onPressed: _selectImage,
                  child: const Text('Select Image'),
                ),ElevatedButton(
                onPressed: _takeImage,
                child: const Text('Take Image'),
              ),]
              )
          ],
        );
  }
}