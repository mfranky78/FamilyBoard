import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button_icon.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  String docId = '';
  String todos = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textEditingController = TextEditingController();

 Future<void> _addShopping(String uid) async {
  String todoText = _textEditingController.text;

  try {
    if (todoText.isNotEmpty) {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);
      await userDocRef.collection('shopping').add({
        'text': todoText,
      });
      _textEditingController.clear();
      print('Subcollection "shopping" erfolgreich erstellt.');
    } else {
      print('Eingabe ist leer.');
    }
  } catch (e) {
    print('Fehler beim Erstellen der Subcollection "shopping": $e');
  }
}
 
  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> _deleteShopping(String docId) async {
    final todoCollection = _firestore.collection('users').doc(getCurrentUserId()).collection('shopping');
    await todoCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Shopping List'),
        ),
        body: Stack(children: [
          BackroundScreen(
            Column(children: [
              SizedBox(
                height: 250,
                child: ContainerGlassFlex(
                    child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/market.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
              ),
              const Text('Erstelle eine Liste deiner Einkäufe'),
              TextfieldEmail(
                hintText: 'Enter your shopping',
                textController: _textEditingController,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  CustomButtonIcon(
                        onTap: () {
                          String uid = getCurrentUserId(); 
                          _addShopping(uid);
                        },
                        icon: Icons.add,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text('Liste',style: TextStyle(fontSize: 26),),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 1,
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  // daten aus der DB holen
                  stream: _firestore.collection('users').doc(getCurrentUserId()).collection('shopping').snapshots(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    // liste der todos zwischenspeichern
                    var shoppings = snapshot.data?.docs;
                    return ListView.builder(
                      itemCount: shoppings!.length,
                      itemBuilder: ((context, index) { 
                        var shopping = shoppings[index];
                        
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                _deleteShopping(shopping.id);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            title: Text(
                              shopping['text'],
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ]),
          )
        ]));
  }
}

