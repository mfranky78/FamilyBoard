import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/team/team_model.dart';
import 'package:famibo/user/user_model.dart';
import 'package:flutter/material.dart';

class TeamMemberPage extends StatefulWidget {
  const TeamMemberPage({super.key});

  @override
  State<TeamMemberPage> createState() => _TeamMemberPageState();
}

class _TeamMemberPageState extends State<TeamMemberPage> {
  List<CustomTeam> teams = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        Padding(
          padding: const EdgeInsets.fromLTRB(0,16,0,0),
          child: ContainerGlassFlex(
            child: Column(
              children: [
                Row(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_sharp, size: 30,),
                  ),
                  const SizedBox(width: 50,),
                  Text('Teammitglieder',style: kTextHeadLine5,),],),
                const SizedBox(height: 20,),
                 Text('Liste der Mitglieder', style: kTextHeadLine10),
                const SizedBox(height: 20,),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('teams').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      var teamDocs = snapshot.data?.docs;
                      teams = teamDocs!
                          .map((doc) => CustomTeam.fromJson(doc.data(), doc.id, ''))
                          .toList();
            
                      return ListView.builder(
                        itemCount: teams.length,
                        itemBuilder: (context, index) {
                          var team = teams[index];
                      
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(100, 255, 255, 255),
                                ),
                                child: Center(
                                  child: Text(
                                    '${team.teamName}',
                                    style: kTextHeadLine10,
                                  ),
                                ),
                              ),
                            ),
                            subtitle: FutureBuilder(
                              future: fetchMembersNames(team.members),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  List<String> memberNames = snapshot.data as List<String>;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: memberNames.map((memberName) {
                                      return Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.white),
                                          color: const Color.fromARGB(100, 255, 255, 255)
                                        ),
                                        margin: const EdgeInsets.only(bottom: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                                              child: Text(
                                                '$memberName',
                                                style: kTextHeadLine9,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _showDeleteDialog(context, team.members[index], index, memberName);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                                child: Icon(Icons.outbond, size: 32,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> fetchMembersNames(List<dynamic> memberIds) async {
    List<String> memberNames = [];

    for (var memberId in memberIds) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(memberId)
          .get();
      if (userSnapshot.exists) {
        CustomUser user =
            CustomUser.fromJson(userSnapshot.data() as Map<String, dynamic>);
        memberNames.add(user.name);
      }
    }

    return memberNames;
  }

  void _showDeleteDialog(BuildContext context, String memberId, int index, String memberName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title:  Text('Mitglied entfernen', style: kTextHeadLine10,),
          content: Text('Möchtest du das Mitglied $memberName wirklich entfernen?', style: kTextHeadLine9,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Abbrechen', style: kTextHeadLine11,),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  teams.forEach((team) {
                    team.members.remove(memberId);
                  });
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mitglied entfernt', style: kTextHeadLine2,),
                    action: SnackBarAction(
                      label: 'Rückgängig',
                      onPressed: () {
                        setState(() {
                          teams.forEach((team) {
                            team.members.insert(index, memberId);
                          });
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Entfernen',style: kTextHeadLine11,),
            ),
          ],
        );
      },
    );
  }
}
