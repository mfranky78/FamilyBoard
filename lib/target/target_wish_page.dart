import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button_icon.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishPage extends StatefulWidget {
  const WishPage({super.key});

  @override
  State<WishPage> createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  String docId = '';
  String wishes = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textEditingController = TextEditingController();

 Future<void> _addWish(String uid) async {
  String wishText = _textEditingController.text;
   try {
    if (wishText.isNotEmpty) {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);
      await userDocRef.collection('wishes').add({
        'text': wishText,
      });
      _textEditingController.clear();
      debugPrint('Subcollection "wishes" erfolgreich erstellt.');
    } else {
      debugPrint('Eingabe ist leer.');
    }
  } catch (e) {
    debugPrint('Fehler beim Erstellen der Subcollection "wishes": $e');
  }
}

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> _deleteWish(String docId) async {
    final wishCollection = _firestore.collection('users').doc(getCurrentUserId()).collection('wishes');
    await wishCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Wish'),
        ),
        body: Stack(
          children: [
            BackroundScreen(Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContainerGlassFlex(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(height: 200, 
                      child: Image.asset('assets/images/child3.png')),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldEmail(
                      textController: _textEditingController,
                       hintText: 'Dein Wunsch', 
                    ),
                    Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   CustomButtonIcon(
                        onTap: () {
                          String uid = getCurrentUserId(); 
                          _addWish(uid);
                        },
                        icon: Icons.add,
                    ),
                  ],
                ),
                              ),
                    const Text('Füge deinen Wunsch hinzu'),
                    Expanded(
                      child: StreamBuilder(
                        // daten aus der DB holen
                         stream: _firestore.collection('users').doc(getCurrentUserId()).collection('wishes').snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          // liste der todos zwischenspeichern
                          var wishes = snapshot.data?.docs;
                          return ListView.builder(
                            itemCount: wishes!.length,
                            itemBuilder: ((context, index) {
                              // einzelnes todo anlegen
                              var wish = wishes[index];
                
                              return ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    _deleteWish(wish.id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                ),
                                title: Text(wish['text'],
                                    style: const TextStyle(fontSize: 20)),
                              );
                            }),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
