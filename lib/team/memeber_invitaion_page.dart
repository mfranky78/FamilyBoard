import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
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
            labelStyle: TextStyle(color: Colors.black54),
            labelText: 'Team-ID',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Abbrechen', style: kTextHeadLine2,),
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
            child: Text('Beitreten', style: kTextHeadLine2,),
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
  if (email == null || email.isEmpty || !email.contains('@')) {
    // Zeige eine Benachrichtigung an, dass die E-Mail ungültig ist.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bitte eine gültige E-Mail-Adresse eingeben.'))
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

  try {
    final bool canLaunchEmail = await canLaunch(emailLaunchUri.toString());
    if (canLaunchEmail) {
      await launch(emailLaunchUri.toString());
    } else {
      // Zeige eine Benachrichtigung an, dass die E-Mail-Anwendung nicht geöffnet werden kann.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-Mail-Anwendung kann nicht geöffnet werden.'))
      );
    }
  } catch (e) {
    // Logge den Fehler und zeige eine Benachrichtigung an.
    debugPrint('Fehler beim Starten der E-Mail-Anwendung: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fehler beim Senden der E-Mail.'))
    );
  }
}


  @override
  Widget build(BuildContext context) {
    const appBarTitle = 'Member Invitation';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          HoneycombBackground(
           child: ContainerGlassFlex(
             child: Column(
               children: [
                 Row(children: [
                   IconButton(onPressed: (){
                     Navigator.of(context).pop();  
                   }, icon: const Icon(Icons.arrow_back_sharp, size: 30,)),
                   const SizedBox(width: 40,),
                   Text(appBarTitle, style: kTextHeadLine5,)],),
                 SizedBox(height: 250,
                   child: Image.asset('assets/images/invite.png')),
                 Text('Team-ID:', style: kTextHeadLine4,),
                 GlassContainerFixText(
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                     child: Text('$teamId', style: kTextHeadLine4,),
                   ),),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                   child: TextfieldEmail(
                     textController: emailController,
                    // keyboardType: TextInputType.emailAddress,
                       lableText: 'E-Mail-Adresse',
                   ),
                 ),
                 const SizedBox(height: 20,),
                 CustomButton(
                   onTap: () => sendEmailInvitation(emailController.text, teamId),
                   icon: Icons.email,
                   text:  Text('Invitation with E-mail',style: kTextHeadLine2,),
                 ),
                 CustomButton(
                   onTap: () => _showJoinTeamDialog(),
                     
                   
                   icon: Icons.link,
                   text:  Text('Join about TeamId',style: kTextHeadLine2,),
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
