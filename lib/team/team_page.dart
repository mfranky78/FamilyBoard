import 'dart:io';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/team/team_firebase_service.dart';
import 'package:famibo/team/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {

   TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  File? image;
  String? teamId;
  CustomTeam? team;

  @override
  void initState() {
    super.initState();
    loadTeamData();
  }

  Future<void> loadTeamData() async {
    String? userTeamId = await getTeamIdForUser(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      teamId = userTeamId;
    });
  
  if (teamId != null) {
      CustomTeam? loadedTeam = await getTeamData(teamId!);
      setState(() {
        team = loadedTeam;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team')),
      body: Stack(
        children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: image != null ? Image.file(image!) : Image.asset('assets/images/teamgroup.png'),
                  ),
                  const SizedBox(height: 50,),
                team != null ?  Text('Team Name: ${team!.teamName}') : Text('No team'),
                 
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teamcreation");
                    },
                    icon: Icons.groups_2,
                    text: const Text('Team Creation'),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teammemeber", arguments: teamId);
                    },
                    icon: Icons.group,
                    text: const Text('Team Member'),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/memberinvitation", arguments: teamId);
                    },
                    icon: Icons.group_add,
                    text: const Text('Team Invitation'),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teamsettings", arguments: teamId);
                    },
                    icon: Icons.group_work,
                    text: const Text('Team Settings'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
