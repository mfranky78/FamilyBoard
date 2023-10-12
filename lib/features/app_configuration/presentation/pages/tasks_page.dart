import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/cutom_button_onpressed.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/textfield_button.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController listTextController = TextEditingController();
  final List<String> shoppingList = [];

  void _addToList() {
    final newItem = listTextController.text;
    if (newItem.isNotEmpty) {
      setState(() {
        shoppingList.add(newItem);
        listTextController.clear();
      });
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
            BackroundScreen(Column(
              children: [
                SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/todo.png',
                      fit: BoxFit.fitWidth,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Füge deine Aufgaben hinzu',
                  style: kTextHeadLine2,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextfieldButton(
                    hintText: 'Posten hinzufügen',
                    textController: listTextController),
                    const SizedBox(height: 10,),
                CustomButtonPressed(
                  onPressed: _addToList,
                  icon: Icons.list,
                  text: const Text('Add'),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20,0,0,0),
                  child: Row(
                    children: [
                      Text(
                        'Liste',
                        style: kTextHeadLine2,
                      ),
                    ],
                  ),
                ),const Padding(
                  padding: EdgeInsets.fromLTRB(10,0,10,0),
                  child: Divider(color: Colors.black,),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: shoppingList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(shoppingList[index]),
                        );
                      }),
                )
              ],
            )),
          ],
        ));
  }
}
