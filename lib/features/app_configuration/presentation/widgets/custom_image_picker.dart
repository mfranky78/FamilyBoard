import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(String?) setImage;
  final String? imagePath;

  const CustomImagePicker({super.key, required this.setImage, this.imagePath});

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  String? imagePath;

  @override
  void initState() {
    super.initState();
    imagePath = widget.imagePath;
  }

  void selectImage() async {
    XFile? tempFilePath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    String? tempImagePath = tempFilePath?.path;
    setState(() {
      imagePath = tempImagePath;
    });
    widget.setImage(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: MediaQuery.of(context).size.width - 100,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: const Color.fromARGB(255, 69, 69, 69),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: selectImage,
          child: imagePath != null
              ? Image.file(
                  File(imagePath ?? ""),
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 100.0,
                )),
        ),
      ),
    );
  }
}
