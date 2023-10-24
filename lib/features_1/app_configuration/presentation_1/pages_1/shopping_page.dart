import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/customglasscontainer.dart';
import 'package:famibo/core/cutom_button_small.dart';
import 'package:famibo/core/textfield_button.dart';
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

  Future<void> _addToDo() async {
    String todoText = _textEditingController.text;
    if (todoText.isNotEmpty) {
      // hinzufügen zur collection
      await _firestore.collection('todos').add({'text': todoText});
      _textEditingController.clear();
    }
  }

  Future<void> _deleteToDo(String docId) async {
    final firestore = FirebaseFirestore.instance;
    final todoCollection = firestore.collection('todos');
    // Hier nutzen wir das Dokument-ID anstelle des Index.
    await todoCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Stack(
        children: [
          BackroundScreen(Column(children: [
            SingleChildScrollView(
              child: ContainerGlassFlex(child: Center(
                child: SizedBox(
                  height: 250,
                
                  child: Image.asset('assets/images/shopbag.png', 
                  fit: BoxFit.scaleDown,)),
              )),
            ),
             TextfieldButton( 
              hintText: 'Enter a new ToDos', 
              textController: _textEditingController, 
             ),
             
          
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonSmall(
                    onTap: _addToDo,
                    icon: Icons.add,
                    text: const Text('Add ToDo'),
                  ),
                    const SizedBox(width: 20,),     
                  CustomButtonSmall(
                    onTap: () {
                      // Zeige eine Bestätigungsnachricht an und lösche die Aufgabe bei Bestätigung.
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Aufgabe löschen?'),
                            content:
                                const Text('Möchtest du diese Aufgabe wirklich löschen?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Abbruch
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Abbrechen'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Bestätigung: Lösche die Aufgabe.
                                  _deleteToDo(todos); // Hier verwenden wir die Dokument-ID.
                                  Navigator.of(context).pop();
                                },
                                child: const Text('entfernen'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icons.delete,
                    text: const Text('Löschen'),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder(
              // daten aus der DB holen
              stream: _firestore.collection('todos').snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Listenübersicht');
                }
                // liste der todos zwischenspeichern
                var todos = snapshot.data?.docs;
                return ListView.builder(
                  itemCount: todos!.length,
                  itemBuilder: ((context, index) {
                    // einzelnes todo anlegen
                    var todo = todos[index];
                   String docId = '';
                    return ListTile(
                      title: Text(
                        todo['text'],
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
      ]
      ),
   )]));
  }
}
