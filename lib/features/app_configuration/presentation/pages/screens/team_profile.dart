

import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/features/app_configuration/presentation/widgets/custom_image_picker.dart';
import 'package:flutter/material.dart';
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

  void pickImageGallery(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        avatarImagePath = pickedImage.path;
      });
      widget.setImage(avatarImagePath);
    }
  }
    void pickImageCamera(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        avatarImagePath = pickedImage.path;
      });
      widget.setImage(avatarImagePath);
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
                        const SizedBox(height: 40,),
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
              bottom: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                  onTap: () {
                    setState(() {
                      avatarImagePath = null;
                    });
                    widget.setImage(null);
                  },
                  // selection: 'Image Cancel',
                  icon: Icons.delete,
                  text: const Text('Delete'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
