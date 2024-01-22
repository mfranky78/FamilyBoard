import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String docId = '';
  String todos = '';
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus(); // Admin-Status beim Initialisieren der Seite prüfen
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> _checkAdminStatus() async {
    String currentUserId = getCurrentUserId();
    var teamSnapshot = await _firestore
        .collection('teams')
        .where('creatorId', isEqualTo: currentUserId)
        .get();

    setState(() {
      isAdmin = teamSnapshot.docs
          .isNotEmpty; // Der Benutzer ist Admin, wenn er mindestens ein Team erstellt hat
    });
  }

  Future<void> _deleteTask(String docId) async {
    try {
      await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('targetTodo')
          .doc(docId)
          .delete();
      debugPrint('Aufgabe erfolgreich gelöscht.');
    } catch (e) {
      debugPrint('Fehler beim Löschen der Aufgabe: $e');
    }
  }

  Future<void> _updateTaskStatus(
      String userId, String targetTodoId, bool isDone) async {
    try {
      DocumentReference targetTodoRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('targetTodo')
          .doc(targetTodoId);

      DocumentSnapshot targetTodoDoc = await targetTodoRef.get();
      Map<String, dynamic> targetTodoData =
          targetTodoDoc.data() as Map<String, dynamic>;
      int points = targetTodoData['points'] ?? 0;

      DocumentReference userRef = _firestore.collection('users').doc(userId);
      DocumentSnapshot userDoc = await userRef.get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      int currentPoints = userData['points'] ?? 0;
      int updatedPoints =
          isDone ? currentPoints + points : currentPoints - points;

      await userRef.update({'points': updatedPoints});
      await targetTodoRef.update({'isDone': isDone});
    } catch (e) {
      debugPrint('Fehler beim Aktualisieren des Status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          BackgroundScreen(Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: ContainerGlassFlex(
                child: Column(children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 90,
                  ),
                  Text('Task List', style: kTextHeadLine5),
                ],
              ),
              SizedBox(
                height: 200,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/todo_work.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Text('Add your tasks', style: kTextHeadLine2),
              const SizedBox(
                height: 20,
              ),
              Text('Liste', style: kTextHeadLine5),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('users')
                    .doc(getCurrentUserId())
                    .collection(
                        'targetTodo') // Geändert von 'tasks' zu 'targetTodo'
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text(
                        'Keine zielorientierten Aufgaben gefunden.');
                  }

                  var tasks = snapshot.data!.docs;
                  return ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    var task = tasks[index].data() as Map<String, dynamic>;
    bool isTaskDone = task['isDone'] ?? false;
    String docId = tasks[index].id;

    return ListTile(
      title: Text(
        task['text'],
        style: TextStyle(
          decoration: isTaskDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text('Punkte: ${task['points']}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Checkbox
          Checkbox(
            value: isTaskDone,
            onChanged: (bool? newValue) {
              _updateTaskStatus(getCurrentUserId(), docId, newValue ?? false);
            },
          ),

          // Reaktivierungs-Button (nur wenn die Aufgabe erledigt ist)
          if (isTaskDone) IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              _updateTaskStatus(getCurrentUserId(), docId, false);
            },
          ),

          // Lösch-Button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteTask(docId);
            },
          ),
        ],
      ),
    );
  },
);

                },
              ))
            ])),
          ))
        ]));
  }
}
