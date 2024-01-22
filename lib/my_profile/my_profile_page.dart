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
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          setState(() {
            imageUrl = userData['url'];
            name = userData['name'];
            email = userData['email'];
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
        body: Stack(children: [
      BackgroundScreen(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
          child: ContainerGlassFlex(
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.arrow_back_sharp, size: 30,)),
               
                  Text('My Profile', style: kTextHeadLine5),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/myprofilesetting");
                      },
                      child: const Icon(Icons.settings),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 250,
                        child: imageUrl != null
                            ? Image.network(imageUrl!, fit: BoxFit.cover)
                            : Image.asset('assets/images/dogchild.png'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('You are login with:', style: kTextHeadLine6),
                      const SizedBox(
                        height: 40,
                      ),
                      GlassContainerFixText(
                          child: Text('$name', style: kTextHeadLine4)),
                      GlassContainerFixText(
                          child: Text('$email', style: kTextHeadLine4)),
                      //  GlassContainerFixText(child: Text('Team: $team')),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      )
    ]));
  }
}
