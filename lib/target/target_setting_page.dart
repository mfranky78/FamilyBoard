import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TargetSettingsPage extends StatefulWidget {
  
 final String? docId;
 final String? targetTodo;
 final int? targetSettingPoint;

 const TargetSettingsPage({super.key, this.targetTodo, this.targetSettingPoint, this.docId});

  @override
  _TargetSettingsPageState createState() => _TargetSettingsPageState();
}


class _TargetSettingsPageState extends State<TargetSettingsPage> {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _targetTodoController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  List<TargetSettingsPage> targetTodoList = [];

   

Future<void> _addTargetTodo() async {
  String targetTodoText = _targetTodoController.text;
  String targetSettingPointText = _pointsController.text;
  try{
  if (targetTodoText.isNotEmpty && targetSettingPointText.isNotEmpty) {
    int targetSettingPoint = int.parse(targetSettingPointText);
    // Prüfen, ob die Umwandlung erfolgreich war
    if (targetSettingPoint != null) {
      // Hinzufügen zur Collection
       DocumentReference userDocRef =
       FirebaseFirestore.instance.collection('users').doc(getCurrentUserId());
      await userDocRef.collection('targetTodo').add({
        'text': targetTodoText,
        'points': targetSettingPoint,
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
    final todoCollection = _firestore.collection('users').doc(getCurrentUserId()).collection('tasks');
    await todoCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Target Settings'),
      ),
      body: Stack(
        children: [
          BackroundScreen(
            Column(
              children: [
                const Text('Gib deinen Tätigkeiten Punkte. Erstelle eine Liste'),
                TextfieldEmail(
                  hintText: 'z.B. Aufräumen',
                  textController: _targetTodoController,
                ),
                TextfieldEmail(
                  hintText: 'Punkte',
                  textController: _pointsController,
                ),
                ElevatedButton(
                  onPressed: _addTargetTodo,  
                  child: const Text('Hinzufügen'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: targetTodoList.length,
                    itemBuilder: (context, index) {
                      final targetTodo = targetTodoList[index];
                      return ListTile(
                        trailing: IconButton(
                                  onPressed: () {
                                    _firestore.collection('targetTodo').doc(targetTodo.toString()).delete();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                ),
                                title: Text(targetTodo.toString(),
                                    style: const TextStyle(fontSize: 20)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}