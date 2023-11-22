import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



Future<CustomUser?> saveUserData({
  required String name, 
  required String email, 
  String teamId = '', 
  String url = '', 
  String member = '', 
  }) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
    'userid' : user.uid,
    'name': name,
    'email': email,
    'url' : url,
    'member' : member,
    'teamId': teamId,
      });
    }
  } catch (e) {
    debugPrint("Fehler beim Speichern der Benutzerdaten: $e");
  }
}

Future<void> upDateUserDataUrl({required String url}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
    'url' : url,
      });
    }
  } catch (e) {
    debugPrint("Fehler beim Speichern der Benutzerdaten: $e");
  }
}

  Future<CustomUser?> getUserData() async {
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
          return CustomUser.fromJson(userData);
        } else {
          debugPrint('Der Benutzer wurde nicht in Firestore gefunden');
          return null; 
        }
      } else {
        debugPrint('Kein aktuell angemeldeter Benutzer');
        return null; 
      }
    } catch (e) {
      debugPrint("Fehler beim Abrufen der Benutzerdaten: $e");
      return null;
    }
  }
