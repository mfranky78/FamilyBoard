import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
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
  String? _teamId; // Zustandsvariable für die Team-ID

  @override
  void initState() {
    super.initState();
    _fetchTeamId();
  }

  Future<void> _fetchTeamId() async {
    _teamId = await _getCurrentUserTeamId(); // Aktualisieren Sie den Zustand mit der abgerufenen Team-ID
    setState(() {}); // Aktualisieren Sie den Zustand, um die Änderungen zu reflektieren
  }


   Future<void> _addTargetTodo() async {
    String targetTodoText = _targetTodoController.text;
    String targetSettingPointText = _pointsController.text;
    String? teamId = await _getCurrentUserTeamId();

    if (targetTodoText.isNotEmpty && targetSettingPointText.isNotEmpty && teamId != null) {
      int targetSettingPoint = int.tryParse(targetSettingPointText) ?? 0;
      
      await _firestore.collection('teams').doc(teamId).collection('targetTodo').add({
        'text': targetTodoText,
        'points': targetSettingPoint,
        'date': Timestamp.fromDate(DateTime.now()),
      }).then((value) => {
        _targetTodoController.clear(),
        _pointsController.clear(),
        debugPrint('TargetTodo erfolgreich zum Team hinzugefügt.')
      }).catchError((error) => debugPrint('Fehler beim Hinzufügen der TargetTodo: $error'));
    } else {
      debugPrint('Eingabe ist leer oder Team-ID ist null.');
    }
  }

  Future<String?> _getCurrentUserTeamId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.get('teamId');
    }
    return null;
  }

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> _deleteTask(String docId) async {
    await _firestore
        .collection('teams')
        .doc(getCurrentUserId())
        .collection('targetTodo')
        .doc(docId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
     body: _teamId == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          HoneycombBackground(
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
                     Text('ToDo Settings', style: kTextHeadLine5),
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
             child:  StreamBuilder<QuerySnapshot>(
                       stream: _firestore
             .collection('teams')
             .doc(_teamId) // Verwenden Sie _teamId hier
             .collection('targetTodo')
             .snapshots(),
                       builder: (context, snapshot) {
               if (snapshot.hasError) {
                 return Text('Error: ${snapshot.error}');
               }
               switch (snapshot.connectionState) {
                 case ConnectionState.waiting: return Text('Loading...');
                 default:
                   return ListView(
                     children: snapshot.data!.docs.map((DocumentSnapshot document) {
                       Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                       return ListTile(
           title: Text(data['text']),
           subtitle: Text('Punkte: ${data['points']}'),
           // Weitere Elemente oder Aktionen
                       );
                     }).toList(),
                   );
               }
             },
           )
           ),
           
               ],
             ),
           ),
          ),
        ],
      ),
    );
  }
}
