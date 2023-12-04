import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/team/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Future<void> joinTeamManually(String uid, String teamId) async {
  print(teamId);
  try {
    // Überprüfe, ob die Team-ID vorhanden ist
    DocumentSnapshot teamSnapshot =
        await FirebaseFirestore.instance.collection('teams').doc(teamId).get();

    if (teamSnapshot.exists) {
          print('Team Snapshot: ${teamSnapshot.data()}');

      // Teammitgliedschaft überprüfen und Benutzer hinzufügen
      CustomTeam team = CustomTeam.fromJson(
        teamSnapshot.data() as Map<String, dynamic>,
        teamId,
      );
      team.addMember(uid);

      // Konvertiere das aktualisierte Team in ein Map-Objekt
      Map<String, dynamic> updatedTeamData = team.customTeamToJson();

      // Team in Firestore aktualisieren
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update(
        updatedTeamData,
      );

      // Benutzerdokument aktualisieren, um die Team-ID zu speichern
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'teamId': teamId,
      });
    } else {
      debugPrint('Team mit der angegebenen Team-ID nicht gefunden.');
    }
  } catch (e) {
    debugPrint("Fehler beim Beitreten des Teams: $e");
  }
}





Future<void> addMemberToTeam(String teamId, String memberId) async {
  print('Manuell eingegebene Team-ID: $teamId');

  try {
    // Holen Sie sich das aktuelle Team-Dokument aus der teams-Sammlung
    DocumentSnapshot teamSnapshot =
        await FirebaseFirestore.instance.collection('teams').doc(teamId).get();

    if (teamSnapshot.exists) {
      // Aktualisieren Sie das Team-Dokument mit der neuen Mitgliedschaft
      List<String> members = List<String>.from(teamSnapshot['members']);
      members.add(memberId);

      // Führen Sie die Aktualisierung in Firestore durch
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'members': members,
      });

      // Aktualisieren Sie das Benutzerdokument mit der Team-ID
      await FirebaseFirestore.instance.collection('users').doc(memberId).update({
        'teamId': teamId,
      });
    } else {
      debugPrint('Das Team wurde nicht in Firestore gefunden. Team-ID: $teamId');
    }
  } catch (e) {
    debugPrint('Fehler beim Hinzufügen des Mitglieds zum Team: $e');
  }
}




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



Future<void> updateTeamId(String userId, String teamId) async {
  try {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore.collection('users').doc(userId).update({
      'teamId': teamId,
    });
  } catch (e) {
    debugPrint('Fehler beim Aktualisieren der Team-ID: $e');
    
  }
}

Future<bool> checkIfUserHasTeam(String userId) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      String teamId = userSnapshot['teamId'];

      if (teamId != null) {
        // Überprüfe, ob die Team-ID in der teams-Sammlung vorhanden ist
        DocumentSnapshot teamSnapshot =
            await _firestore.collection('teams').doc(teamId).get();

        return teamSnapshot.exists;
      }
    }
  } catch (e) {
    debugPrint("Fehler beim Überprüfen der Team-ID: $e");
  }

  return false;
}


Future<void> updateTeamData({String? teamName, String members = '', bool? admin, String? teamId, required url}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'teamName': teamName,
        'teamId': teamId,
        'members': members,
        'admin': admin,
        'url': url,
      });
    }
  } catch (e) {
    debugPrint("Fehler beim Speichern der Benutzerdaten: $e");
  }
}

// Future<void> upDateTeamDataUrl({required String url, required String teamName}) async {
//   try {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (FirebaseAuth.instance.currentUser != null) {
//       await FirebaseFirestore.instance.collection('teams').doc(user!.uid).update({
//     'url' : url,
//     'teamName': teamName,
//       });
//     }
//   } catch (e) {
//     debugPrint("Fehler beim Speichern der Benutzerdaten: $e");
//   }
// }

   Future<CustomTeam?> getTeamData() async {
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
            return CustomTeam.fromJson(teamData, teamId);
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
      return 'Benutzer hat noch kein Team'; 
    }
  } catch (e) {
    debugPrint("Fehler beim Abrufen der Team-ID für den Benutzer: $e");
    return 'Fehler TeamId';
  }
}

Future<CustomTeam?> getTeamDataFromFirebase(String teamId) async {
  try {
    DocumentSnapshot teamSnapshot =
        await FirebaseFirestore.instance.collection('teams').doc(teamId).get();

    if (teamSnapshot.exists) {
      Map<String, dynamic> teamData = teamSnapshot.data() as Map<String, dynamic>;
      return CustomTeam.fromJson(teamData, teamId);
    } else {
      debugPrint('Das Team wurde nicht in Firestore gefunden');
      return null; 
    }
  } catch (e) {
    debugPrint("Fehler beim Abrufen der Teamdaten: $e");
    return null;
  }
}
