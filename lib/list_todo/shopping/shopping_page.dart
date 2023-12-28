import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button_icon.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/textfield_text.dart';
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
        body: Stack(children: [
          BackgroundScreen(
            Padding(
              padding: const EdgeInsets.fromLTRB(0,16,0,0),
              child: ContainerGlassFlex(
                child: Column(children: [
                  Row(children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_sharp, size: 30,)),
                    const SizedBox(width: 70,),
                    Text('Shopping List',style: kTextHeadLine5),],),
                  SizedBox(
                    height: 200,
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
                   Text('Create a list of your purchases',style: kTextHeadLine2),
                  TextfieldText(
                    hintText: 'Enter your shopping:',
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
                  const Text('Liste',style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Divider(
                        color: Colors.black26,
                        height: 1,
                        thickness: 2,
                      ),
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
                        return ContainerGlassFlex(
                          child: ListView.builder(
                            itemCount: shoppings!.length,
                            itemBuilder: ((context, index) { 
                              var shopping = shoppings[index];
                              
                              return ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    _deleteShopping(shopping.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                title: Text(
                                  shopping['text'],style: kTextHeadLine4,
                                ),
                              );
                            }),
                          ),
                        );
                      }),
                    ),
                  ),
                ]),
              ),
            ),
          )
        ]));
  }
}

