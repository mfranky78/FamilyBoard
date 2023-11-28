import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Wochenkalender'),
      ),
      body: Stack(
        children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: ListView(
                    children: List.generate(8, (index) {
                      final day = DateTime.now().add(Duration(days: index));
                      return DayTile(day: day);
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayTile extends StatefulWidget {
  final DateTime day;

  const DayTile({required this.day});




  @override
  _DayTileState createState() => _DayTileState();
}

 
class _DayTileState extends State<DayTile> {
  late Stream<QuerySnapshot> _kalenderStream;
  String entry = '';


  @override
  void initState() {
    super.initState();

    // Hier wird der Stream initialisiert
    _kalenderStream = _getKalenderEntries(widget.day);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.day.toLocal().toString().split(' ')[0],
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: StreamBuilder(
        // Hier wird der StreamBuilder für die Firestore-Subcollection "kalender" verwendet
        stream: _kalenderStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Fehler beim Laden der Einträge: ${snapshot.error}');
          } else {
            // Hier werden die Einträge angezeigt
            var entries = snapshot.data?.docs;
            return Column(
              children: entries?.map<Widget>((entry) {
                return Text(entry['entry'] as String);
              }).toList() ?? [],
            );
          }
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Eintrag für ${widget.day.toLocal().toString().split(' ')[0]}'),
                content: TextField(
                  onChanged: (value) {
                    setState(() {
                      entry = value;
                    });
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Abbrechen'),
                  ),
                  TextButton(
                    onPressed: () {
                      _saveEntryToFirestore(widget.day, entry);
                      Navigator.pop(context);
                    },
                    child: const Text('Speichern'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> _getKalenderEntries(DateTime day) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      CollectionReference kalenderCollection = userDocRef.collection('kalender');

      // Hier wird der Stream für die Firestore-Subcollection "kalender" erstellt
      return kalenderCollection
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(day))
          .where('date', isLessThan: Timestamp.fromDate(day.add(Duration(days: 1))))
          .snapshots();
    }

    // Falls kein Benutzer angemeldet ist, wird ein leerer Stream zurückgegeben
    return Stream.empty();
  }

 Future<void> _saveEntryToFirestore(DateTime day, String entry) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(userId);
        CollectionReference kalenderCollection = userDocRef.collection('kalender');
        await kalenderCollection.add({
          'date': Timestamp.fromDate(day),
          'entry': entry,
        });

        print('Eintrag erfolgreich in der Subcollection "kalender" gespeichert.');
      }
    } catch (e) {
      print('Fehler beim Speichern des Eintrags: $e');
    }
  }
}
