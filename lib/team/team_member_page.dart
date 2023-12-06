import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/team/team_model.dart';
import 'package:flutter/material.dart';

class TeamMemberPage extends StatefulWidget {
  const TeamMemberPage({super.key});


  @override
  State<TeamMemberPage> createState() => _TeamMemberPageState();
}

class _TeamMemberPageState extends State<TeamMemberPage> {
  CustomTeam? team;
  List<String>? members = [];

  @override
  void initState() {
    super.initState();
    // Rufe hier alle notwendigen Initialisierungsmethoden auf
    fetchTeam(); // Hole das Team aus Firebase
  }

  Future<void> fetchTeam() async {
    // Hole das Team aus Firebase
    DocumentSnapshot teamSnapshot =
        await FirebaseFirestore.instance.collection('teams').doc('teamid').get();

    if (teamSnapshot.exists) {
      setState(() {
        team;       
      });
      fetchMembers(); // Rufe die Mitglieder des Teams ab
    }
  }

  Future<void> fetchMembers() async {
  
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('teams').doc('teamid').collection('members').get();

    List<String> memberNames =
        snapshot.docs.map((doc) => doc['username'].toString()).toList();

    setState(() {
      members = memberNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teammitglieder'),
      ),
      body: BackroundScreen(
        Column(
          children: [
            const Text('Liste der Mitglieder', style: TextStyle(fontSize: 22)),
            if (members != null && members!.isNotEmpty) // Überprüfe, ob die Mitgliederliste nicht leer ist
              Expanded(
                child: ListView.builder(
                  itemCount: members!.length,
                  itemBuilder: (context, index) {
                    String username = members![index];
                    return ListTile(
                      title: Text(username),
                      // Füge hier weitere Informationen hinzu, die du anzeigen möchtest
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
