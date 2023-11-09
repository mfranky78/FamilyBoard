import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileSettings extends StatefulWidget {
  const MyProfileSettings({super.key});

  @override
  _MyProfileSettingsState createState() => _MyProfileSettingsState();
}

class _MyProfileSettingsState extends State<MyProfileSettings> {
  final List<File> _selectedImages = []; // Liste zum Speichern der ausgewählten Bilder
  final picker = ImagePicker();
  XFile? image;

  Future<void> pickImageGallery() async {
    final returnedImage = await picker.pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
     
      _selectedImages.add(File(image!.path)); // Bild zur Liste hinzufügen
    });
  }
    Future<String> uploadUserImageToStorage(File imageFile, String userId)async{
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child("userProfiles/$userId/userImage");
      TaskSnapshot uploadTask = await storageReference.putFile(imageFile);

      String downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
      
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future pickImageCamera() async {
    final returnedImage = await picker.pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImages.add(File(returnedImage.path)); // Bild zur Liste hinzufügen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _selectedImages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Image.file(_selectedImages[index]),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              color: Colors.blue, // Hintergrundfarbe
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: pickImageCamera,
                      child: const Text('Bild aufnehmen'),
                    ),
                    ElevatedButton(
                      onPressed: pickImageGallery,
                      child: const Text('Bild auswählen'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
