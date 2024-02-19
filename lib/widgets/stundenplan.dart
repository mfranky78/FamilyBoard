import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_button_icon.dart';
import 'package:famibo/core/custom_button_text.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MultipleTimetables extends StatefulWidget {
  const MultipleTimetables({super.key});

  @override
  _MultipleTimetablesState createState() => _MultipleTimetablesState();
}

class _MultipleTimetablesState extends State<MultipleTimetables> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> personNames = [];
  String currentPerson = "";
  Map<String, List<List<String>>> timetableData = {};

  @override
  void initState() {
    super.initState();
    _loadPersonNames();
  }

  String getWeekdayName(int dayNumber) {
    List<String> weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag'
    ];
    return weekdays[dayNumber - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        HoneycombBackground(
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_sharp, size: 30),
                    ),
                    const SizedBox(width: 80),
                    Text('Stundenplan', style: kTextHeadLine5),
                  ],
                ),
              ),
              CustomButton(
                onTap: () => _addPerson(context),
                icon: Icons.person_add,
                text: Text(
                  'Person hinzufügen',
                  style: kTextHeadLine4,
                ),
              ),
              const SizedBox(width: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  children: personNames
                      .map((personName) => Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Row(
                              children: [
                                CustomButtonText(
                                  onPressed: () async {
                                    await _loadTimetableData(personName);
                                    setState(() {
                                      debugPrint(
                                          "Person $personName ausgewählt");
                                      currentPerson = personName;
                                    });
                                  },
                                  text: Text(
                                    personName,
                                    style: kTextHeadLine2,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                CustomButtonIcon(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Person löschen', style: kTextHeadLine4,),
                                          content: Text(
                                              'Möchtest du $personName wirklich löschen?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Abbrechen', style: kTextHeadLine2,),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Löschen', style: kTextHeadLine2,),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _deletePerson(personName);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: 
                                    Icons.delete,
                                  ),
                                
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              if (currentPerson.isNotEmpty)
                Expanded(
                  child: Timetable(
                    key: ValueKey(
                        currentPerson), // Verwende currentPerson als Key
                    personName: currentPerson,
                    timetableData: timetableData[currentPerson] ?? [],
                    onUpdate: (day, hour, text) {
                      final state = context
                          .findAncestorStateOfType<_MultipleTimetablesState>();
                      state?._addTimetableEntry(currentPerson, day, hour, text);
                    },
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> _loadPersonNames() async {
    try {
      var collection = _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('persons');
      var snapshot = await collection.get();
      var loadedPersonNames = snapshot.docs.map((doc) => doc.id).toList();

      setState(() {
        personNames = loadedPersonNames;
        currentPerson =
            loadedPersonNames.isNotEmpty ? loadedPersonNames.first : '';
      });

      if (currentPerson.isNotEmpty) {
        await _loadTimetableData(currentPerson);
      }
    } catch (e) {
      debugPrint("Fehler beim Laden der Personenliste: $e");
    }
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
              (data['timetableData'] as List).map((entry) {
            return [
              entry['day'] as String,
              entry['hour'] as String,
              entry['text'] as String,
            ];
          }).toList();

          debugPrint(
              "Geladene Stundenplandaten: $loadedTimetableData"); // Debug-Ausgabe

          setState(() {
            timetableData[personName] = loadedTimetableData;
          });
        } else {
          debugPrint("Keine Stundenplandaten gefunden für $personName");
        }
      } else {
        debugPrint("Snapshot existiert nicht für $personName");
      }
    } catch (e) {
      debugPrint("Fehler beim Laden der Personendaten: $e");
    }
  }

  Future<void> _addPerson(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Neue Person hinzufügen',
            style: kTextHeadLine5,
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Name der Person',
              labelStyle: kTextHeadLine2,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Abbrechen', style: kTextHeadLine4),
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

                  await _savePersonData(
                      newPersonName, timetableData[currentPerson] ?? []);
                }

                Navigator.of(context).pop();
              },
              child: Text(
                'Hinzufügen',
                style: kTextHeadLine4,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addTimetableEntry(
      String personName, String day, int hour, String text) async {
    final entry = [day, hour.toString(), text];
    setState(() {
      final existingEntryIndex = timetableData[personName]
          ?.indexWhere((e) => e[0] == day && e[1] == hour.toString());
      if (existingEntryIndex != null && existingEntryIndex >= 0) {
        timetableData[personName]?[existingEntryIndex] = entry;
      } else {
        timetableData[personName] = (timetableData[personName] ?? [])
          ..add(entry);
      }
    });
    await _savePersonData(personName, timetableData[personName] ?? []);
  }

  Future<void> _savePersonData(
      String personName, List<List<String>> timetableEntries) async {
    try {
      await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('persons')
          .doc(personName)
          .set({
        'timetableData': timetableEntries
            .map((entry) => {
                  'day': entry[0],
                  'hour': entry[1],
                  'text': entry[2],
                })
            .toList(),
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
    try {
      await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('persons')
          .doc(personName)
          .delete();

      setState(() async {
        personNames.remove(personName);
        if (currentPerson == personName) {
          currentPerson = personNames.isNotEmpty ? personNames.first : '';
          if (currentPerson.isNotEmpty) {
            await _loadTimetableData(currentPerson);
          }
        }
      });
    } catch (e) {
      debugPrint("Fehler beim Löschen der Person: $e");
    }
  }
}

class Timetable extends StatefulWidget {
  final String personName;
  final List<List<String>> timetableData;
  final Function(String, int, String) onUpdate;

  const Timetable({
    super.key,
    required this.personName,
    required this.timetableData,
    required this.onUpdate,
  });

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  @override
  Widget build(BuildContext context) {
    return ContainerGlassFlex(
      child: ListView(
        children: [
          for (int i = 1; i <= 7; i++)
            DayTimetable(
              day: 'Tag $i',
              personName: widget.personName,
              timetableData: widget.timetableData,
              onUpdate: (day, hour, text) {
                final state =
                    context.findAncestorStateOfType<_MultipleTimetablesState>();
                state?._addTimetableEntry(widget.personName, day, hour, text);
              },
            ),
        ],
      ),
    );
  }
}

class DayTimetable extends StatefulWidget {
  final String day;
  final String personName;
  final List<List<String>> timetableData;
  final Function(String, int, String) onUpdate;

  const DayTimetable({
    super.key,
    required this.day,
    required this.personName,
    required this.timetableData,
    required this.onUpdate,
  });

  @override
  State<DayTimetable> createState() => _DayTimetableState();
}

String getWeekdayName(String dayNumber) {
  List<String> weekdays = [
    'Montag',
    'Dienstag',
    'Mittwoch',
    'Donnerstag',
    'Freitag',
    'Samstag',
    'Sonntag'
  ];
  return weekdays[int.parse(dayNumber) -
      1]; // Beachte, dass wir dayNumber - 1 verwenden, da die Liste bei 0 anfängt
}

int extractDayNumber(String dayString) {
  final match = RegExp(r'\d+').firstMatch(dayString);
  if (match != null) {
    return int.tryParse(match.group(0) ?? '') ??
        1; // Standardmäßig auf 1 setzen, wenn keine Zahl gefunden wird
  }
  return 1; // Standardmäßig auf 1 setzen, wenn keine Übereinstimmung gefunden wird
}

class _DayTimetableState extends State<DayTimetable> {
  @override
  Widget build(BuildContext context) {
    int dayNumber = extractDayNumber(widget.day);
    String weekdayName = getWeekdayName(dayNumber.toString());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weekdayName,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 19, 75, 9)),
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
                    initialValue: _getTimetableEntry(widget.day, i),
                    onChanged: (entry) {
                      widget.onUpdate(widget.day, i, entry);
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _getTimetableEntry(String day, int hour) {
    final entry = widget.timetableData.firstWhere(
      (e) => e[0] == day && e[1] == hour.toString(),
      orElse: () => ['', '', ''],
    );
    return entry[2];
  }
}
