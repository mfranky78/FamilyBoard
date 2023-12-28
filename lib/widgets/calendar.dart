import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          BackgroundScreen(
            Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_sharp, size: 30)),
                    const SizedBox(width: 30),
                    Text('Wochenkalender', style: kTextHeadLine5),
                  ],
                ),
              ),
              Expanded(
                child: ContainerGlassFlex(
                  child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final day = DateTime.now().add(Duration(days: index));
                      return DayTile(day: day);
                    },
                  ),
                ),
              ),
            ]),
          )
        ]));
  }
}

class DayTile extends StatefulWidget {
  final DateTime day;

  const DayTile({required this.day, Key? key}) : super(key: key);

  @override
  _DayTileState createState() => _DayTileState();
}

class _DayTileState extends State<DayTile> {
  late Stream<QuerySnapshot> _kalenderStream;
  TextEditingController entryController = TextEditingController();
  String entry = '';

  @override
  void initState() {
    super.initState();
    _kalenderStream = _getKalenderEntries(widget.day);
  }

  Future<void> _saveEntryToFirestore(DateTime day, String entry) async {
    if (entry.isEmpty) {
      // Optional: Benutzer benachrichtigen, dass der Eintrag nicht leer sein darf.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Der Eintrag darf nicht leer sein.')),
      );
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(userId);
        CollectionReference kalenderCollection =
            userDocRef.collection('kalender');

        await kalenderCollection.add({
          'date': Timestamp.fromDate(day),
          'entry': entry, 
        }
        );
            entryController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Eintrag erfolgreich gespeichert.')),
        );
      }
    } catch (e) {
      debugPrint('Fehler beim Speichern des Eintrags: $e');
      // Optional: Benutzer benachrichtigen, dass ein Fehler aufgetreten ist.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Speichern des Eintrags.')),
      );
    }
  }

  Future<void> _deleteEntryFromFirestore(DocumentReference entryDocRef) async {
    try {
      await entryDocRef.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Eintrag erfolgreich gelöscht.')),
      );
    } catch (e) {
      debugPrint('Fehler beim Löschen des Eintrags: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Löschen des Eintrags.')),
      );
    }
    
  }

  Stream<QuerySnapshot> _getKalenderEntries(DateTime day) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      CollectionReference kalenderCollection =
          userDocRef.collection('kalender');

      return kalenderCollection
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(day))
          .where('date',
              isLessThan: Timestamp.fromDate(day.add(const Duration(days: 1))))
          .snapshots();
    }
    return const Stream.empty();
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE, dd. MMMM');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        _formatDate(widget.day),
        style: const TextStyle(fontSize: 20),
      ),
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
          stream: _kalenderStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Fehler: ${snapshot.error}');
            }

            var entries = snapshot.data?.docs ?? [];
            return Column(
              children: entries.map<Widget>((document) {
                var entryData = document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(entryData['entry'] as String),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        _deleteEntryFromFirestore(document.reference),
                  ),
                );
              }).toList(),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
             controller: entryController,
            onChanged: (value) => entry = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Neuer Eintrag',
            ),
          ),
        ),
        CustomButton(
          onTap: () => _saveEntryToFirestore(widget.day, entry),
          icon: Icons.save_alt_rounded,
          text: Text(
            'Speichern',
            style: kTextHeadLine2,
          ),
        )
      ],
    );
  }
}
