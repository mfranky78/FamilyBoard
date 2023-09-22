import 'dart:io';

import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TeamProfile extends StatefulWidget {
  const TeamProfile({super.key});

  @override
  State<TeamProfile> createState() => _TeamProfileState();
}

class _TeamProfileState extends State<TeamProfile> {
  File? profileImage; // Hier wird das aktuelle Profilbild gespeichert

  Future pickImage(ImageSource src) async {
    final image = await ImagePicker().pickImage(source: src);
    if (image != null) {
      setState(() {
        profileImage = File(image.path); // Das Profilbild wird aktualisiert
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      profileImage = null; // Hier können Sie das Profilbild löschen, wenn nötig
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
        Scaffold(
            appBar: AppBar(
              title: const Text('Teamprofil bearbeiten'),
            
            ),
            body: Stack(children: [
              BackroundScreen(
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          selection: 'Gallery',
                          icon: Icons.browse_gallery,
                          category: '',
                          image: const AssetImage(''),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          selection: 'Kamera',
                          icon: Icons.camera,
                          category: '',
                          image: const AssetImage(''),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (profileImage != null)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            FileImage(profileImage!), // Das Profilbild anzeigen
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: () {
                          removeImage(0); // Profilbild löschen
                        },
                        selection: 'Löschen',
                        icon: Icons.delete,
                        category: '',
                        image: const AssetImage(''),
                      ),
                    ],
                  ),
                ),
            ]));
  }
}
