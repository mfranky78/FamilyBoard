import 'dart:io';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_textfield.dart';
import 'package:famibo/team/team_firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TeamCreation extends StatefulWidget {
  final Function(String?) setImage;

  const TeamCreation({super.key, required this.setImage});

  @override
  State<TeamCreation> createState() => _TeamCreationState();
}

class _TeamCreationState extends State<TeamCreation> {
  final TextEditingController _textController = TextEditingController();
  String? avatarImagePath;
  final picker = ImagePicker();
  File? image;

  Future pickImageGallery() async {
    try {
      final imageXFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageXFile == null) return;
      final imageTemp = File(imageXFile.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final imageXFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageXFile == null) return;
      final imageTemp = File(imageXFile.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<String> uploadTeamImageToStorage(File imageFile, String teamId) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("teamProfiles/$teamId/teamImage");
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Teamprofil erstellen'),
      ),
      body: Stack(
        children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 200,
                            width: 250,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: image != null
                                  ? Image.file(image!)
                                  : Image.asset('assets/images/child1.png'),
                            ),
                          ),
                          const SizedBox(height: 40),
                          CustomTextField(
                            textController: _textController,
                            decoration: const InputDecoration(),
                            label: 'Team Name',
                          ),
                          CustomButton(
                            onTap: pickImageGallery,
                            icon: Icons.image,
                            text: const Text('Bild auswählen'),
                          ),
                          CustomButton(
                            onTap: pickImageCamera,
                            icon: Icons.add_a_photo_rounded,
                            text: const Text('Bild aufnehmen'),
                          ),
                          CustomButton(
                              onTap: () async {
                                if (image != null &&
                                    FirebaseAuth.instance.currentUser != null) {
                                      String teamName = _textController.text;
                                  String imageStorageUrl =
                                      await uploadTeamImageToStorage(
                                          image!,
                                          FirebaseAuth
                                              .instance.currentUser!.uid);
                                  await upDateTeamDataUrl(url: imageStorageUrl, teamName: teamName); 
                                  await createTeam(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    teamName, 
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              icon: Icons.save,
                              text: const Text('Bestätigen')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
