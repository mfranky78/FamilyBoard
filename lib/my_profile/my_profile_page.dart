import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String? imageUrl;
  String? name;
  String? email;
  String? team;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

          setState(() {
            imageUrl = userData['url'];
            name = userData['name'];
            email = userData['email'];
            team = userData['member'];
          });
        }
      }
    } catch (e) {
      debugPrint("Fehler beim Abrufen der Benutzerdaten: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'), 
          actions:  [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(onTap: (){
              Navigator.pushNamed(context, "/myprofilesetting");
            },child: const Icon(Icons.settings),),
          )
          ],
        ),
        body: Stack(
          children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Column(
                children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: imageUrl != null
                                ? Image.network(imageUrl!)
                                : Image.asset('assets/images/dogchild.png'),
                          ),
                        const Text('Persönliche Daten', style: kTextHeadLine6),
                        const SizedBox(height: 40,),
                         GlassContainerFixText(child: Text('Name: $name')),
                          GlassContainerFixText(child: Text('E-Mail: $email')),
                          GlassContainerFixText(child: Text('Team: $team')),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        ]));
  }
}
