import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:flutter/material.dart';

// class ActivityModel {
//   String activity;
//   int points;

//   ActivityModel({required this.activity, required this.points});
// }


class TargetSettingsPage extends StatefulWidget {
  
 final String? docId;
 final String? targetTodo;
 final int? targetSettingPoint;

 TargetSettingsPage({super.key, this.targetTodo, this.targetSettingPoint, this.docId});

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
  
  if (targetTodoText.isNotEmpty && targetSettingPointText.isNotEmpty) {
    int targetSettingPoint = int.parse(targetSettingPointText);
    // Prüfen, ob die Umwandlung erfolgreich war
    if (targetSettingPoint != null) {
      // Hinzufügen zur Collection
      await _firestore.collection('targetTodo').add({
        'text': targetTodoText,
        'points': targetSettingPoint,
      });
      _targetTodoController.clear();
      _pointsController.clear();
    }
  }
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