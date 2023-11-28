import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/team/team_firebase_service.dart';
import 'package:famibo/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ... (deine anderen Import-Anweisungen)

class MemberInvitationPage extends StatefulWidget {
  const MemberInvitationPage({super.key});

  @override
  _MemberInvitationPageState createState() => _MemberInvitationPageState();
}

class _MemberInvitationPageState extends State<MemberInvitationPage> {
  String teamId = '';
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTeamId();
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

 void sendEmail() async {
  final String email = emailController.text;

  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bitte geben Sie eine E-Mail-Adresse ein.'),
      ),
    );
    return;
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': 'Einladung zum Team',
      'body': 'Du wurdest zu unserem Team eingeladen! Team-ID: $teamId',
    },
  );

  if (await canLaunch(emailLaunchUri.toString())) {
    await launch(emailLaunchUri.toString());
  } else {
    debugPrint('Fehler beim Öffnen der E-Mail-Anwendung');
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
                  onTap: sendEmail,
                  icon: Icons.email,
                  text: const Text('Invitation with E-mail'),
                  
                ),
                
                CustomButton(
                  onTap: () {
                    // Logik für Link-Einladung hier einfügen
                  },
                  icon: Icons.link,
                  text: const Text('Invitation about Link'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
