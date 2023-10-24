import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/customglasscontainer.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/textfield_button.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _listTextController = TextEditingController();
  final List<String> toDoList = [];

  get onPressed => null;

  void _addToList() {
    final newItem = _listTextController.text;
    if (newItem.isNotEmpty) {
      setState(() {
        toDoList.add(newItem);
        _listTextController.clear();
      });
    }
  }
  Future<void> _addToDoList() async {
    String todoText = _listTextController.text;
    if (todoText.isNotEmpty) {
      await _firestore.collection('todos').add({'text': todoText});
      _listTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks', style: kTextHeadLine1),
        ),
        body: Stack(
          children: [
            BackroundScreen(Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: SizedBox(height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      SizedBox(
                         height: 200,
                          child: ContainerGlassFlex(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/todo_work.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Füge Aufgaben hinzu',
                        style: kTextHeadLine2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextfieldButton(
                          hintText: 'Posten hinzufügen',
                          textController: _listTextController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          onTap: _addToList, 
                          icon: Icons.add, 
                          text: const Text('Add')),
                      const SizedBox(
                        height: 10,
                      ),
                        CustomButton(
                          onTap: (){
                            setState(() {
                              toDoList.clear();
                            });
                          },
                          icon: Icons.clear, 
                          text: const Text('Clear')),
                       const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              'Liste',
                              style: kTextHeadLine1, textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Divider(
                          color: Colors.black,
                          height: 3,
                          thickness: 2,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: toDoList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(toDoList[index].toString()),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )),
          ],
        ));
  }
}
