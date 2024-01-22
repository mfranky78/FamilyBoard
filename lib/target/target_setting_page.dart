import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TargetSettingsPage extends StatefulWidget {
  final String? docId;
  final String? targetTodo;
  final int? targetSettingPoint;

  const TargetSettingsPage(
      {super.key, this.targetTodo, this.targetSettingPoint, this.docId});

  @override
  _TargetSettingsPageState createState() => _TargetSettingsPageState();
}

class _TargetSettingsPageState extends State<TargetSettingsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _targetTodoController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  List<TargetSettingsPage> targetTodoList = [];
  DateTime selectedDate = DateTime.now();

  Future<void> _addTargetTodo() async {
    String targetTodoText = _targetTodoController.text;
    String targetSettingPointText = _pointsController.text;
    try {
      if (targetTodoText.isNotEmpty && targetSettingPointText.isNotEmpty) {
        int targetSettingPoint = int.parse(targetSettingPointText);
        if (targetSettingPoint != null) {
          DocumentReference userDocRef = FirebaseFirestore.instance
              .collection('users')
              .doc(getCurrentUserId());
          await userDocRef.collection('targetTodo').add({
            'text': targetTodoText,
            'points': targetSettingPoint,
            'date': Timestamp.fromDate(DateTime.now()), // Datum hinzufügen
          });
          _targetTodoController.clear();
          _pointsController.clear();
          debugPrint('Subcollection "targetTodo" erfolgreich erstellt.');
        } else {
          debugPrint('Eingabe ist leer.');
        }
      }
    } catch (e) {
      debugPrint('Fehler beim Erstellen der Subcollection "targetTodo": $e');
    }
  }

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

 Future<void> _deleteTask(String docId) async {
  try {
    await _firestore
        .collection('users')
        .doc(getCurrentUserId())
        .collection('targetTodo')
        .doc(docId)
        .delete();
    debugPrint('Aktivität erfolgreich gelöscht.');
  } catch (e) {
    debugPrint('Fehler beim Löschen der Aktivität: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackgroundScreen(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: ContainerGlassFlex(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                              size: 30,
                            )),
                        const SizedBox(
                          width: 50,
                        ),
                        Text('Target Settings', style: kTextHeadLine5),
                      ],
                    ),
                    SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/child.png')),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Give your activities points. Create a list:',
                        style: kTextHeadLine2),
                    TextfieldEmail(
                      lableText: 'z.B. clean up',
                      textController: _targetTodoController,
                    ),
                    TextfieldEmail(
                      lableText: 'Points',
                      textController: _pointsController,
                    ),
                    CustomButton(
                      onTap: _addTargetTodo,
                      icon: Icons.add_box,
                      text: Text('Insert', style: kTextHeadLine2),
                    ),
                    Expanded(
  child: StreamBuilder<QuerySnapshot>(
    stream: _firestore
        .collection('users')
        .doc(getCurrentUserId())
        .collection('targetTodo')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Text("Keine Aktivitäten gefunden.");
      }
      var targetTodos = snapshot.data!.docs;
      return ListView.builder(
        itemCount: targetTodos.length,
        itemBuilder: (context, index) {
          DocumentSnapshot documentSnapshot = targetTodos[index];
          Map<String, dynamic> targetTodo = documentSnapshot.data() as Map<String, dynamic>? ?? {};

          String todoText = targetTodo['text'] ?? 'Kein Text';
          int points = targetTodo['points'] ?? 0;
          Timestamp? timestamp = targetTodo['date'] as Timestamp?;
          String formattedDate = '';
          if (timestamp != null) {
            DateTime date = timestamp.toDate();
            formattedDate = DateFormat('dd.MM.yyyy').format(date);
          } else {
            formattedDate = 'Kein Datum';
          }

          return ListTile(
            title: Text(todoText),
            subtitle: Text('Punkte: $points | Datum: $formattedDate'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteTask(documentSnapshot.id); // Löschfunktion aufrufen
              },
            ),
          );
        },
      );
    },
  ),
),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
