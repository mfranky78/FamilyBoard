import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/team/team_firebase_service.dart';
import 'package:famibo/team/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberInvitationPage extends StatefulWidget {
  const MemberInvitationPage({super.key});

  @override
  _MemberInvitationPageState createState() => _MemberInvitationPageState();
}

class _MemberInvitationPageState extends State<MemberInvitationPage> {
  String? teamId = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController teamIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTeamId();
  }
 Future<void> _showJoinTeamDialog() async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Einem Team beitreten'),
        content: TextField(
          controller: teamIdController,
          decoration: const InputDecoration(
            labelText: 'Team-ID',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () async {
              String teamId = teamIdController.text ?? '';

              if (teamId.isNotEmpty) {
                // Direkt die Funktion aufrufen, um dem Team beizutreten
                await joinTeamManually(FirebaseAuth.instance.currentUser!.uid, teamId);
              } else {
                debugPrint('Ungültige Team-ID');
              }
              Navigator.of(context).pop();
            },
            child: const Text('Beitreten'),
          ),
        ],
      );
    },
  );
}




  Future<void> fetchTeamId() async {
    try {
      CustomTeam? team = await getTeamData();

      if (team != null) {
        setState(() {
          teamId = team.teamId;
        });
      } else {
        debugPrint('Team nicht gefunden.');
      }
    } catch (e) {
      debugPrint("Fehler beim Abrufen der Team-ID: $e");
    }
  }

  Future<void> sendEmailInvitation(String? email, String? teamId) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Einladung zum Team',
        'body': 'Du wurdest zu unserem Team eingeladen! Team-ID: $teamId',
      },
    );

    try {
      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        debugPrint('Fehler beim Öffnen der E-Mail-Anwendung');
      }
    } catch (e) {
      debugPrint('Fehler beim Starten der E-Mail-Anwendung: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const appBarTitle = 'Member Invitation';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text(appBarTitle)),
      body: Stack(
        children: [
          BackroundScreen(
            Column(
              children: [
                Image.asset('assets/images/invite.png'),
                Text('Team ID: $teamId'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-Mail-Adresse',
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () => sendEmailInvitation(emailController.text, teamId),
                  icon: Icons.email,
                  text: const Text('Invitation with E-mail'),
                ),
                CustomButton(
                  onTap: () => _showJoinTeamDialog(),
                    
                  
                  icon: Icons.link,
                  text: const Text('Join about TeamId'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
