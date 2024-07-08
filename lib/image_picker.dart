import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker({super.key, required this.onPickedImage});
  Function(File) onPickedImage;
  @override
  State<UserImagePicker> createState() {
    // TODO: implement createState
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  void _pickImage() async{
    final picker  = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if(picker==null){
      return;
    }
    setState(() {
      _pickedImageFile = File(picker.path);
    });
    widget.onPickedImage(_pickedImageFile!);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile!=null?FileImage(_pickedImageFile!):null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          label: Text(
            "Take a picture",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: Icon(Icons.camera_alt),
        ),
      ],
    );
  }
}
