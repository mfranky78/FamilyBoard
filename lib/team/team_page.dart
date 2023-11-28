import 'dart:io';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/team/team_firebase_service.dart';
import 'package:famibo/team/team_model.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  File? image;
  String? teamId = '';
  CustomTeam? team;
  String? teamName = '';

  @override
  void initState() {
    super.initState();
   
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
                    child: image != null
                        ? Image.file(image!)
                        : Image.asset('assets/images/teamgroup.png'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // if (team != null)
                  FutureBuilder(
                      future: getTeamData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                              'Fehler beim Laden der Benutzerdaten: ${snapshot.error}');
                        } else {
                          CustomTeam? team = snapshot.data;
                          if (team != null) {
                            return Column(
                              children: [
                                Text(style: kTextHeadLine2,'Teamname: ${team.teamName}')
                                
                              ],
                            );
                          } else {
                            return const Text('Benutzer nicht gefunden');
                          }
                        }
                      }),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teamcreation");
                    },
                    icon: Icons.groups_2,
                    text: const Text('Team Creation'),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teammemeber",
                          arguments: teamId);
                    },
                    icon: Icons.group,
                    text: const Text('Team Member'),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/memberinvitation",
                          arguments: teamId);
                    },
                    icon: Icons.group_add,
                    text: const Text('Team Invitation'),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teamsettings",
                          arguments: teamId);
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
