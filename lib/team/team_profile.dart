



import 'dart:io';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/widgets/custom_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TeamProfile extends StatefulWidget {
  final Function(String?) setImage;

  const TeamProfile({super.key, required this.setImage});

  @override
  State<TeamProfile> createState() => _TeamProfileState();
}

class _TeamProfileState extends State<TeamProfile> {
 
  String? avatarImagePath;

  void setAvatarImagePath(imagePath) {
    avatarImagePath = imagePath ?? "";
  }

  // void pickImageGallery(ImageSource source) async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       avatarImagePath = pickedImage.path;
  //     });
  //     widget.setImage(avatarImagePath);
  //   }
  // }

    File? imageGallery;
  Future pickImageGallery([ImageSource? imageSource]) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      //print(image.toString());
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.imageGallery = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  //   void pickImageCamera(ImageSource source) async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (pickedImage != null) {
  //     setState(() {
  //       avatarImagePath = pickedImage.path;
  //     });
  //     widget.setImage(avatarImagePath);
  //   }
  // }
     File? imageCamera;
  Future pickImageCamera([ImageSource? camera]) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      //print(image.toString());
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.imageCamera = imageTemp);
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
    appBar: AppBar(
      title: const Text('Teamprofil bearbeiten'),
    ),
    body: Stack(
      children: [
        BackroundScreen(
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomImagePicker(
                        setImage: setAvatarImagePath,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onTap: () {
                          pickImageGallery(ImageSource.gallery);
                        },
                        text: const Text('Bild aus Galerie auswählen'),
                        icon: Icons.image,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        onTap: () {
                          pickImageCamera(ImageSource.camera);
                        },
                        text: const Text('Foto mit Kamera aufnehmen'),
                        icon: Icons.camera,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (avatarImagePath != null)
          Positioned(
            bottom: 50,
            right: 50,
            child: CustomButton(
              onTap: () {
                setState(() {
                  avatarImagePath = null;
                });
                widget.setImage(null);
              },
              icon: Icons.delete,
              text: const Text('Delete'),
            ),
          ),
      ],
    ),
  );
}
}