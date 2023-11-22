import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/team/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> createTeam(String uid, String teamName,) async {
  try {
    // Team-Dokument mit automatisch generierter ID
    DocumentReference teamDocRef = await FirebaseFirestore.instance.collection('teams').add({
      'teamName': teamName,
      'creatorId': uid, 
      'members': [uid], 
      'admins': [uid],
    });

   
    // Aktualisiere das Benutzerdokument mit der ID des Teams, dem der Benutzer beigetreten ist
    String? teamId = teamDocRef.id;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'teamId': teamId,
    });
  } catch (e) {
    debugPrint("Fehler beim Erstellen des Teams: $e");
  }
}


// Future<void> saveTeamData({required String teamName, String member = '', required bool admin, required String teamId}) async {
//   try {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (FirebaseAuth.instance.currentUser != null) {
//       await FirebaseFirestore.instance.collection('teams').doc().set({
//         'teamName': teamName,
//         'teamId': teamId,
//         'member': member,
//         'admin': admin,
//       });
//     }
//   } catch (e) {
//     debugPrint("Fehler beim Speichern der Benutzerdaten: $e");
//   }
// }

Future<void> updateTeamData({String? teamName, String member = '', bool? admin, String? teamId}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'teamName': teamName,
        'teamId': teamId,
        'member': member,
        'admin': admin,
      });
    }
  } catch (e) {
    debugPrint("Fehler beim Speichern der Benutzerdaten: $e");
  }
}

Future<void> upDateTeamDataUrl({required String url, required String teamName}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance.collection('teams').doc(user!.uid).update({
    'url' : url,
    'teamName': teamName,
      });
    }
  } catch (e) {
    debugPrint("Fehler beim Speichern der Benutzerdaten: $e");
  }
}

  Future<CustomTeam?> getTeamData(String s) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(user.uid).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        String teamId = userData['teamId'];

        if (teamId != null) {
          DocumentSnapshot teamSnapshot =
              await _firestore.collection('teams').doc(teamId).get();

          if (teamSnapshot.exists) {
            Map<String, dynamic> teamData = teamSnapshot.data() as Map<String, dynamic>;
            return CustomTeam.fromJson(teamData);
          } else {
            debugPrint('Das Team wurde nicht in Firestore gefunden');
            return null; 
          }
        } else {
          debugPrint('Der Benutzer gehört zu keinem Team');
          return null; 
        }
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

Future<void> deleteTeam(String teamId, String uid) async {
  try {
    // Holen Sie sich eine Referenz zum Team-Dokument
    DocumentReference teamDocRef = FirebaseFirestore.instance.collection('teams').doc(teamId);

    // Holen Sie sich das Team-Dokument
    DocumentSnapshot teamSnapshot = await teamDocRef.get();

    // Überprüfe, ob das Team existiert
    if (teamSnapshot.exists) {
      // Holen Sie sich die Daten des Teams
      Map<String, dynamic> teamData = teamSnapshot.data() as Map<String, dynamic>;

      // Überprüfe, ob der Benutzer der Teamersteller oder Admin ist
      if (uid == teamData['creatorId'] || teamData['admins'][uid] == true) {
        // Lösche das Team-Dokument
        await teamDocRef.delete();
      } else {
        debugPrint('Du hast keine Berechtigung, dieses Team zu löschen.');
      }
    } else {
      debugPrint('Team nicht gefunden.');
    }
  } catch (e) {
    debugPrint("Fehler beim Löschen des Teams: $e");
  }
}

Future<String?> getTeamIdForUser(String uid) async {
  try {
    QuerySnapshot teamSnapshot = await FirebaseFirestore.instance
        .collection('teams')
        .where('members', arrayContains: uid)
        .get();

    if (teamSnapshot.docs.isNotEmpty) {
      return teamSnapshot.docs.first.id;
    } else {
      return null; // Der Benutzer gehört zu keinem Team
    }
  } catch (e) {
    debugPrint("Fehler beim Abrufen der Team-ID für den Benutzer: $e");
    return null;
  }
}