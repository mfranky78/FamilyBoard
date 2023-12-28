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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  
  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> _deleteTask(String docId) async {
    final todoCollection = _firestore
        .collection('users')
        .doc(getCurrentUserId())
        .collection('tasks');
    await todoCollection.doc(docId).delete();
  }

  Future<void> _updateTaskStatus(
      String userId, String targetTodoId, bool isDone) async {
    try {
      DocumentReference targetTodoRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('targetTodo')
          .doc(targetTodoId);
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
                height: 250,
                child: ContainerGlassFlex(
                    child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/todo_work.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
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
                  return ContainerGlassFlex(
                      child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index].data() as Map<String, dynamic>;

                      return ListTile(
                        title: Text(task['text'], style: kTextHeadLine6),
                        subtitle: Text('Punkte: ${task['points']}'),
                        trailing: Checkbox(
                          value: task['isDone'] ?? false,
                          onChanged: (bool? newValue) {
                            _updateTaskStatus(getCurrentUserId(),
                                tasks[index].id, newValue ?? false);
                          },
                        ),
                          
                      );
                    },
                  ));
                },
              ))
            ])),
          ))
        ]));
  }
}
