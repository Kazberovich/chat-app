import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final void Function(File pickedImageFile) avatarPickedFunction;

  AvatarPicker(this.avatarPickedFunction);

  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  final _picker = ImagePicker();
  File _pickedFile;

  void _pickImage() async {
    final pickedImage = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedFile = File(pickedImage.path);
    });
    widget.avatarPickedFunction(_pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: _pickedFile != null ? FileImage(_pickedFile) : null,
        ),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.add_a_photo),
          label: Text("Add image"),
        ),
      ],
    );
  }
}
