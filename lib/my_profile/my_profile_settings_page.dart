import 'dart:io';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/user/user_firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileSettings extends StatefulWidget {
  const MyProfileSettings({super.key});

  @override
  _MyProfileSettingsState createState() => _MyProfileSettingsState();
}

class _MyProfileSettingsState extends State<MyProfileSettings> {
  // Liste zum Speichern der ausgewählten Bilder
  final picker = ImagePicker();
  File? image;

 
  Future pickImageGallery() async {
    try {
      final imageXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      //print(image.toString());
      if (imageXFile == null) return;
      final imageTemp = File(imageXFile.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final imageXFile = await ImagePicker().pickImage(source: ImageSource.camera);
      //print(image.toString());
      if (imageXFile == null) return;
      final imageTemp = File(imageXFile.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: Stack(
        children: [BackroundScreen(
          ContainerGlassFlex(
            child: Column(
              children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
                child: Container(height: 200,width: 200,
                
                  child: image != null ? Image.file(image!) : Image.asset('assets/images/dogchild.png')),
              ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    CustomButton(
                      onTap: pickImageCamera,
                      icon: Icons.add_a_photo_rounded,
                      text: const Text('Bild aufnehmen'),
                      
                    ),
                    CustomButton(
                      onTap: pickImageGallery, 
                      icon: Icons.image, 
                      text: const Text('Bild auswählen'),
                      
                    ),
                    CustomButton(onTap: () async {
                     if (  image != null && FirebaseAuth.instance.currentUser != null) { 
                      String imageStorageUrl = await uploadUserImageToStorage(image!, FirebaseAuth.instance.currentUser!.uid);
                       await upDateUserDataUrl(url: imageStorageUrl);
                       Navigator.of(context).pop();
                     }
                    }, icon: Icons.save,
                    text: const Text('Bestätigen')),
                  ],
                ),
              ),
            ),
                    ],
                  ),
          ),
   )],)); 
  }
}
