import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:flutter/material.dart';



class Timetable extends StatefulWidget {
  const Timetable({super.key});

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  // Hier können Sie Daten für den Stundenplan speichern, z.B. den Stundenplan der Woche.
  List<List<String>> timetableData = [
    ["Montag", "", "", "", "", ""],
    ["Dienstag", "", "", "", "", ""],
    ["Mittwoch", "", "", "", "", ""],
    ["Donnerstag", "", "", "", "", ""],
    ["Freitag", "", "", "", "", ""],
    ["Samstag", "", "", "", "", ""],
    ["Sonntag", "", "", "", "", ""],
  ];

  void updateEntry(int dayIndex, int hourIndex, String entry) {
    setState(() {
      timetableData[dayIndex][hourIndex] = entry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Stundenplan'),
      ),
      body: BackroundScreen(
        ContainerGlassFlex(
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: timetableData.length,
                itemBuilder: (context, index) {
                  final dayData = timetableData[index];
                  return DayTimetable(
                    dayData: dayData,
                    onEntryUpdate: (entry, hourIndex) {
                      updateEntry(index, hourIndex, entry);
                    },
                  );
                },
              ),
            ),
          ),
        ),
   ) );
  }
}

class DayTimetable extends StatelessWidget {
  final List<String> dayData;
  final Function(String, int) onEntryUpdate;

  const DayTimetable({super.key, required this.dayData, required this.onEntryUpdate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dayData[0], // Wochentag
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        for (int i = 1; i < dayData.length; i++) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  'Stunde ${i}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  initialValue: dayData[i],
                  onChanged: (entry) {
                    onEntryUpdate(entry, i);
                  },
                ),
           ), ],
     ), ],
                  ],
    
       // Trennlinie zwischen den Tagen
      
    );
  }
}
