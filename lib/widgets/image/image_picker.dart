import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  //const UserImagePicker({Key? key}) : super(key: key);

  final void Function(File pickedImage) pickedImageFn;

  UserImagePicker(this.pickedImageFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage = File('');

  void pickImage() async {
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.camera,
       imageQuality: 100,
      maxHeight: 150,
      maxWidth: 150,

    );
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
    widget.pickedImageFn(File(pickedImage!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != File('') ? FileImage(_pickedImage) : null,
          backgroundColor: Colors.grey,
        ),
        TextButton.icon(
          onPressed: pickImage,
          icon: Icon(Icons.add_a_photo),
          label: Text('Add Image'),
        )
      ],
    );
  }
}
