import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final Function(File) imagePickFn;

  const UserImagePicker(this.imagePickFn, {Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final _picker = ImagePicker();
    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (imageFile == null) return;
    setState(() {
      _pickedImage = File(imageFile.path);
    });
    widget.imagePickFn(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 30,
        backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage!),
      ),
      TextButton.icon(
        onPressed: _pickImage,
        icon: const Icon(Icons.image),
        label: const Text('Add image'),
      ),
    ]);
  }
}
