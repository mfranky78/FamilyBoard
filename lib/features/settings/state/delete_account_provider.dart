import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final deleteAccountProvider = Provider((ref) {
  return DeleteAccountNotifier();
});

class DeleteAccountNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> deleteAccount() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
        // Hier könntest du zusätzliche Bereinigungslogik hinzufügen
      } catch (e) {
        debugPrint("Fehler beim Löschen des Kontos: $e");
        rethrow; // Wirf den Fehler, damit die UI darauf reagieren kann
      }
    }
  }
}
