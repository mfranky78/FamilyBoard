import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button_icon.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/textfield_button.dart';
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
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _addTask() async {
  
    String todoText = _textEditingController.text;
    if (todoText.isNotEmpty) {
      // hinzufügen zur collection
      await _firestore.collection('tasks').add({'text': todoText});
      _textEditingController.clear();
    }
  }

  Future<void> _deleteTask(String docId) async {
    final todoCollection = _firestore.collection('tasks');
    // Hier nutzen wir das Dokument-ID anstelle des Index.
    await todoCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task List'),
        ),
        body: Stack(children: [
          BackroundScreen(
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(children: [
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
                  const Text('Füge Aufgaben hinzu'),
                  TextfieldButton(
                    hintText: 'Posten hinzufügen',
                    textController: _textEditingController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButtonIcon(
                          onTap: _addTask,
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
                      height: 3,
                      thickness: 2,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      // daten aus der DB holen
                      stream: _firestore.collection('tasks').snapshots(),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        // liste der todos zwischenspeichern
                        var tasks = snapshot.data?.docs;
                        return ListView.builder(
                          itemCount: tasks!.length,
                          itemBuilder: ((context, index) {
                            // einzelnes todo anlegen
                            var task = tasks[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    _deleteTask(task.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                title: Text(
                                  task['text'],
                                ),
                              ),
                            );
                          }),
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
