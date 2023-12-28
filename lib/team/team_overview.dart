import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:flutter/material.dart';

class TeamOverview extends StatelessWidget {
  const TeamOverview({super.key});

  Future<void> _deleteTeam(String teamId) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).delete();
      // Optional: Zeige eine Benachrichtigung an, dass das Team gelöscht wurde
    } catch (e) {
      // Optional: Fehlerbehandlung
      debugPrint("Fehler beim Löschen des Teams: $e");
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, String teamId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Team löschen'),
          content: const Text('Möchtest du dieses Team wirklich löschen?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteTeam(teamId);
              },
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BackgroundScreen(
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
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
                      Text(
                        'Teamoverview',
                        style: kTextHeadLine5,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset('assets/images/teamall.png'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Here you can see all the teams that have been created.',
                      style: kTextHeadLine2,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('teams')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            'Fehler beim Laden der Teams: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      var teamDocs = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        // Änderung hier: Füge `return` hinzu
                        itemCount: teamDocs.length,
                        itemBuilder: (context, index) {
                          var team = teamDocs[index];
                          return ListTile(
                            title: Text(team[
                                'teamName'], style: kTextHeadLine2,), // Ersetze 'teamName' durch dein tatsächliches Feld
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _showDeleteConfirmationDialog(
                                  context, team.id),
                            ),
                          );
                        },
                      );
                    },
                  )),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
