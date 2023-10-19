import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class ImagePickerProfile extends StatefulWidget {
  @override
  _ImagePickerProfileState createState() => _ImagePickerProfileState();
}

class _ImagePickerProfileState extends State<ImagePickerProfile> {
  File? _image;

  Future getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
   Future getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: [
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
          ),
          ElevatedButton(onPressed: getImageFromGallery,
        
        child: const Icon(Icons.add_a_photo),),
        ElevatedButton(onPressed: getImageFromCamera,
        
        child: const Icon(Icons.camera_alt),),
        ],
      ),
     
      
      
       
    );
  }
}
