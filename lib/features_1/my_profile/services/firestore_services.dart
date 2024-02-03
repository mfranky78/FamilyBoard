import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/features_1/my_profile/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserState> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      return UserState(
        imageUrl: userData['url'],
        name: userData['name'],
        email: userData['email'],
      );
    }
    return UserState(); // Leeren Zustand zurückgeben, wenn kein Benutzer vorhanden ist
  }
}
