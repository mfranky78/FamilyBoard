import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MultipleTimetables extends StatefulWidget {
  const MultipleTimetables({Key? key}) : super(key: key);

  @override
  _MultipleTimetablesState createState() => _MultipleTimetablesState();
}

class _MultipleTimetablesState extends State<MultipleTimetables> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> personNames = [];
  String currentPerson = "";
  Map<String, List<List<String>>> timetableData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Timetables'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addPerson(context);
                  },
                  child: const Text('Person hinzufügen'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Wrap(
                    children: [
                      for (String personName in personNames)
                        ElevatedButton(
                          onPressed: () async {
                            await _loadTimetableData(personName);
                            setState(() {
                              currentPerson = personName;
                            });

                            // Hier die Funktion aufrufen, um die Daten an Firebase zu senden
                            await _savePersonData(personName, timetableData[personName] ?? []);
                          },
                          child: Text(personName),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (currentPerson.isNotEmpty)
              Expanded(
                child: Timetable(
                  personName: currentPerson,
                  timetableData: timetableData[currentPerson] ?? [],
                  onUpdate: (day, hour, text) {
                   
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _addPerson(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Neue Person hinzufügen'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Name der Person'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () async {
                final newPersonName = controller.text;
                if (newPersonName.isNotEmpty) {
                  setState(() {
                    personNames.add(newPersonName);
                    currentPerson = newPersonName;
                    timetableData[currentPerson] = [];
                  });

                  await _savePersonData(newPersonName, timetableData[currentPerson] ?? []);
                }

                Navigator.of(context).pop();
              },
              child: const Text('Hinzufügen'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addTimetableEntry(String personName, String day, int hour, String text) async {
    final entry = [day, hour.toString(), text];

    setState(() {
      timetableData[personName]?.add(entry);
    });

    await _savePersonData(personName, timetableData[personName] ?? []);
  }

  Future<void> _savePersonData(String personName, List<List<String>> timetableEntries) async {
    try {
      await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('persons')
          .doc(personName)
          .set({
        'timetableData': timetableEntries.map((entry) {
          return {
            'day': entry[0],
            'hour': entry[1],
            'text': entry[2],
          };
        }).toList(),
      });
    } catch (e) {
      debugPrint("Fehler beim Speichern der Personendaten: $e");
    }
  }

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> _deletePerson(String personName) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUserId())
        .collection('persons')
        .doc(personName)
        .delete();
    setState(() {
      personNames.remove(personName);
      timetableData.remove(personName);
    });
  }

  Future<void> _loadTimetableData(String personName) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('persons')
          .doc(personName)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('timetableData')) {
          List<List<String>> loadedTimetableData =
              List<List<String>>.from(data['timetableData']
                  .map((entry) => [
                        entry['day'].toString(),
                        entry['hour'].toString(),
                        entry['text'].toString(),
                      ]));
          print('Loaded Timetable Data: $loadedTimetableData');

          // Hier können Sie die geladenen Daten für die Anzeige verwenden.
          setState(() {
            timetableData[personName] = loadedTimetableData;
          });
        }
      }
    } catch (e) {
      debugPrint("Fehler beim Laden der Personendaten: $e");
    }
  }
}

class Timetable extends StatelessWidget {
  final String personName;
  final List<List<String>> timetableData;
  final Function(String, int, String) onUpdate;

  const Timetable({
    Key? key,
    required this.personName,
    required this.timetableData,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 1; i <= 7; i++)
          DayTimetable(
            day: 'Tag $i',
            personName: personName,
            timetableData: timetableData,
            onUpdate: onUpdate,
          ),
      ],
    );
  }
}

class DayTimetable extends StatelessWidget {
  final String day;
  final String personName;
  final List<List<String>> timetableData;
  final Function(String, int, String) onUpdate;

  const DayTimetable({
    Key? key,
    required this.day,
    required this.personName,
    required this.timetableData,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        for (int i = 1; i <= 8; i++)
          Row(
            children: [
              Expanded(
                child: Text(
                  'Stunde $i',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextFormField(
                  initialValue: _getTimetableEntry(personName, day, i),
                  onChanged: (entry) {
                    onUpdate(day, i, entry);
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }

  String _getTimetableEntry(String personName, String day, int hour) {
    // Überprüfen, ob timetableData nicht null ist und personName enthält
    if (timetableData != null && timetableData.isNotEmpty) {
      // Überprüfen, ob ein Eintrag für den Tag und die Stunde vorhanden ist
      final entry = timetableData.firstWhere(
        (entry) => entry[0] == day && entry[1] == hour.toString(),
        orElse: () => ['', '', ''],
      );
      // Wenn ein Eintrag vorhanden ist, gib den Text zurück
      return entry[2];
    }
    return '';
  }
  
}
