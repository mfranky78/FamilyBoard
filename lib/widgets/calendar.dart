import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
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
              padding: const EdgeInsets.fromLTRB(0,40,0,0),
              child: ListView(
                children: List.generate(8, (index) {
                  // Erstelle eine Kachel für jeden Wochentag
                  final day = DateTime.now().add(Duration(days: index));
                  return DayTile(day: day);
                }),
              ),
            ),
          ),
        ))],)  );
  }
}

class DayTile extends StatefulWidget {
  final DateTime day;

  DayTile({required this.day});

  @override
  _DayTileState createState() => _DayTileState();
}

class _DayTileState extends State<DayTile> {
  String entry = '';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.day.toLocal().toString().split(' ')[0],style: const TextStyle(fontSize: 20),), // Wochentag-Anzeige
      subtitle: Text(entry), // Anzeige der täglichen Einträge
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          // Öffnen eines Dialogs zum Bearbeiten des Eintrags
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
}
