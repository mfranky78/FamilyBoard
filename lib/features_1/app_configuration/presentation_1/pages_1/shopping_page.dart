import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'Enter a new ToDo',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
          ElevatedButton(
            onPressed: _addToDo,
            child: const Text('Add ToDo'),
          ),
          Expanded(
            child: StreamBuilder(
              // daten aus der DB holen
              stream: _firestore.collection('todos').snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Es lädt noch');
                }

                // liste der todos zwischenspeichern
                var todos = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: todos!.length,
                  itemBuilder: ((context, index) {
                    // einzelnes todo anlegen
                    var todo = todos[index];
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
        ],
      ),
    );
  }
}