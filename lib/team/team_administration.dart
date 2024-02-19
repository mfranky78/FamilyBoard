import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/team/team_model.dart';
import 'package:famibo/user/user_model.dart';

class TeamAdminPage extends StatefulWidget {
  const TeamAdminPage({super.key});

  @override
  State<TeamAdminPage> createState() => _TeamAdminPageState();
}

class _TeamAdminPageState extends State<TeamAdminPage> {
  List<CustomTeam> teams = [];
  Map<String, CustomUser> allUsers = {};
  Map<String, bool> adminSwitchStates = {};


  bool isCurrentUserAdmin(String teamId) {
  String currentUserId = getCurrentUserId();
  var teamIndex = teams.indexWhere((t) => t.teamId == teamId);
  if (teamIndex != -1) {
    return teams[teamIndex].admins.contains(currentUserId);
  }
  return false;
}


  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> fetchAllUsers() async {
    var userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      allUsers = Map.fromIterable(userSnapshot.docs,
          key: (doc) => doc.id,
          value: (doc) =>
              CustomUser.fromJson(doc.data() as Map<String, dynamic>));
    });
  }

  void toggleAdminStatus(String teamId, String memberId, bool isAdmin) async {
    var teamIndex = teams.indexWhere((t) => t.teamId == teamId);
    if (teamIndex != -1) {
      setState(() {
        if (isAdmin) {
          teams[teamIndex].admins.add(memberId);
        } else {
          teams[teamIndex].admins.remove(memberId);
        }
      });
      // Aktualisiere das Team-Dokument in Firestore
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'admins': teams[teamIndex].admins,
      }).catchError((error) {
        // Fehlerbehandlung, falls erforderlich
        print("Fehler beim Aktualisieren der Admins: $error");
      });
    }
  }

  bool isUserAdmin(String userId, List<CustomTeam> teams) {
    return teams.any((team) => team.admins.contains(userId));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HoneycombBackground(
         child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: ContainerGlassFlex(
                child: Column(children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_sharp, size: 30),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  Text('Team Rights', style: kTextHeadLine5),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Administratoren verfügen über die vollständige Kontrolle der Anwendungen und können Mitglieder des Teams verwalten',
                    style: kTextHeadLine2),
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/adminVector.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Team Member List',
                style: kTextHeadLine10,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('teams')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    var teamDocs = snapshot.data?.docs;
                    teams = teamDocs!
                        .map((doc) => CustomTeam.fromJson(
                            doc.data(), doc.id, ''))
                        .toList();

                    return ListView.builder(
  itemCount: teams.length,
  itemBuilder: (context, index) {
    CustomTeam team = teams[index];

    return TeamListItem(
      team: team,
      allUsers: allUsers,
      onAdminToggle: toggleAdminStatus,
      isCurrentUserAdmin: isCurrentUserAdmin, // Übergeben der Methode als Parameter
    );
  },
);

                  },
                ),
              )
            ])))));
  }
}

class TeamListItem extends StatefulWidget {
  final CustomTeam team;
  final Map<String, CustomUser> allUsers;
  final Function(String, String, bool) onAdminToggle;
  final isCurrentUserAdmin;

   const TeamListItem({
    super.key,
    required this.team,
    required this.allUsers,
    required this.onAdminToggle,
    required this.isCurrentUserAdmin, // Fügen Sie die Methode als Parameter hinzu
  });

  @override
  _TeamListItemState createState() => _TeamListItemState();
}

class _TeamListItemState extends State<TeamListItem> {
  late List<bool> adminStatuses;

  @override
  void initState() {
    super.initState();
    adminStatuses = widget.team.members
        .map((memberId) => widget.team.admins.contains(memberId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> memberWidgets = [];
    for (int i = 0; i < widget.team.members.length; i++) {
      String memberId = widget.team.members[i];
      String memberName = widget.allUsers[memberId]?.name ?? 'Unknown';
      bool isAdmin = adminStatuses[i];
      bool showSwitch = widget.isCurrentUserAdmin(widget.team.teamId); // Übergeben Sie den aktuellen Benutzer als Parameter

      memberWidgets.add(ListTile(
        title: Text(
          memberName,
          style: kTextHeadLine2,
        ),
        trailing: showSwitch ? Switch(
          value: isAdmin,
          onChanged: (value) {
            setState(() {
              adminStatuses[i] = value;
            });
            widget.onAdminToggle(widget.team.teamId, memberId, value);
          },
         ) : null,
      ));
    }

    return Column(
      children: [
        Text(widget.team.teamName, style: kTextHeadLine5),
        ...memberWidgets,
      ],
    );
  }
}
