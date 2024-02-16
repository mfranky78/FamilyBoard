import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String docId = '';
  String todos = '';
  bool isAdmin = false;
  String? _teamId; // Zustandsvariable für die Team-ID

  @override
  void initState() {
    super.initState();
    _fetchTeamId();
    _checkAdminStatus(); // Admin-Status beim Initialisieren der Seite prüfen
  }

  Future<void> _fetchTeamId() async {
    _teamId = await _getCurrentUserTeamId(); // Abrufen und Speichern der teamId
    setState(() {}); // Zustand aktualisieren, um Änderungen zu reflektieren
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<String?> _getCurrentUserTeamId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      return userDoc.get('teamId');
    }
    return null;
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

  Future<void> _assignTaskToTeamMembers(
      Map<String, dynamic> taskData, List<String> memberIds) async {
    try {
      for (String memberId in memberIds) {
        // Erstelle oder aktualisiere die Aufgabe in der targetTodo-Sammlung jedes Mitglieds
        DocumentReference targetTodoRef = _firestore
            .collection('teams')
            .doc(memberId)
            .collection('targetTodo')
            .doc();
        await targetTodoRef.set(taskData);
      }
      debugPrint('Aufgabe erfolgreich an Teammitglieder zugewiesen.');
    } catch (e) {
      debugPrint('Fehler beim Zuweisen der Aufgabe an Teammitglieder: $e');
    }
  }

  Future<void> _deleteTask(String targetTodoId) async {
    try {
      // Zuerst die Team-ID des aktuellen Benutzers abrufen
      String? teamId = await _getCurrentUserTeamId();
      if (teamId != null) {
        // Verwenden Sie die abgerufene Team-ID, um auf die richtige Sammlung zuzugreifen
        await _firestore
            .collection('teams')
            .doc(teamId) // Verwenden Sie teamId hier
            .collection('targetTodo')
            .doc(targetTodoId)
            .delete();
        debugPrint('Aufgabe erfolgreich gelöscht.');
      } else {
        debugPrint('Fehler beim Löschen der Aufgabe: Team-ID ist null.');
      }
    } catch (e) {
      debugPrint('Fehler beim Löschen der Aufgabe: $e');
    }
  }

  Future<void> _updateTaskStatus(
      String teamId, String targetTodoId, bool isDone) async {
    try {
      // Zugriff auf die spezifische targetTodo-Aufgabe im Team
      DocumentReference targetTodoRef = _firestore
          .collection('teams')
          .doc(teamId) // Verwenden Sie die teamId statt userId
          .collection('targetTodo')
          .doc(targetTodoId);

      // Aktualisieren des isDone-Status der Aufgabe
      await targetTodoRef.update({'isDone': isDone});
      debugPrint('Aufgabenstatus erfolgreich aktualisiert.');

      // Optional: Benutzerpunkte aktualisieren, wenn das Teil Ihrer Logik ist
      // Hinweis: Dies setzt voraus, dass Sie die userId irgendwie verfügbar haben
      // Beispiel: Sie könnten die userId als Parameter der Methode übergeben oder global speichern
      // Hier ist ein einfaches Beispiel, wie Sie die Benutzerpunkte basierend auf dem Aufgabenstatus aktualisieren könnten:
      if (isDone) {
        // Beispiellogik, anpassen nach Bedarf
        DocumentSnapshot targetTodoDoc = await targetTodoRef.get();
        Map<String, dynamic> targetTodoData =
            targetTodoDoc.data() as Map<String, dynamic>;
        int points = targetTodoData['points'] ?? 0;

        // Hier müssten Sie die userId haben, um das Benutzerdokument zu aktualisieren
        String userId =
            "userId"; // Dies muss entsprechend Ihrer Logik festgelegt werden
        DocumentReference userRef = _firestore.collection('users').doc(userId);
        DocumentSnapshot userDoc = await userRef.get();
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        int currentPoints = userData['points'] ?? 0;
        int updatedPoints = currentPoints + points;

        await userRef.update({'points': updatedPoints});
        debugPrint('Benutzerpunkte basierend auf Aufgabenstatus aktualisiert.');
      }
    } catch (e) {
      debugPrint('Fehler beim Aktualisieren des Aufgabenstatus: $e');
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
                  Text('ToDo List', style: kTextHeadLine5),
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
                  child: _teamId == null
                      ? const Center(
                          child:
                              CircularProgressIndicator()) 
                      : StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('teams')
                              .doc(_teamId)
                              .collection('targetTodo')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Text(
                                  'Keine zielorientierten Aufgaben gefunden.');
                            }

                            var tasks = snapshot.data!.docs;
                           return ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    var task = tasks[index].data() as Map<String, dynamic>;
    bool isTaskDone = task['isDone'] ?? false;

    Timestamp timestamp = task['date']; 
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(dateTime); 

    return ListTile(
      title: Text(
        task['text'],
        style: TextStyle(
          decoration: isTaskDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text('Punkte: ${task['points']}\n$formattedDate'), 
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Checkbox
          Checkbox(
            value: isTaskDone,
            onChanged: (bool? newValue) {
              if (_teamId != null) {
                _updateTaskStatus(
                    _teamId!,
                    tasks[index].id,
                    newValue ?? false);
              }
            },
          ),

          if (isTaskDone)
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: () {
                _updateTaskStatus(
                    _teamId!,
                    tasks[index].id,
                    false);
              },
            ),

          // Löschen-Button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteTask(tasks[index].id);
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
