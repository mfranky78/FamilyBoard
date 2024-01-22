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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackgroundScreen(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: ContainerGlassFlex(
                child: Column(
                  children: [
                     Row(children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: const Icon(Icons.arrow_back_sharp, size: 30,)),
                      const SizedBox(width: 100,),
                       Text('Team', style: kTextHeadLine5,)],),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: image != null
                          ? Image.file(image!)
                          : SizedBox(height: 150,
                            child: Image.asset('assets/images/teamgroup.png')),
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
                      text:  Text('Team Creation',style: kTextHeadLine9),
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, "/teammemeber",
                            arguments: teamId);
                      },
                      icon: Icons.group,
                      text:  Text('Team Member',style: kTextHeadLine9),
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, "/memberinvitation",
                            arguments: teamId);
                      },
                      icon: Icons.group_add,
                      text:  Text('Team Invitation',style: kTextHeadLine9),
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, "/teamsettings",
                            arguments: teamId);
                      },
                      icon: Icons.group_work,
                      text:  Text('Team Settings',style: kTextHeadLine9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
