import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/login/login_page.dart';
import 'package:flutter/material.dart';
 import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccount extends StatelessWidget {
   DeleteAccount({super.key});
 

// Firebase-Authentifizierungsinstanz erstellen
final FirebaseAuth _auth = FirebaseAuth.instance;

// Benutzerkonto löschen
Future<void> _deleteAccount() async {
  User? user = _auth.currentUser;
  if (user != null) {
    try {
      await user.delete();
    } catch (e) {
      debugPrint("Fehler beim Löschen des Kontos: $e");
    }
  }
}

  void deletionConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konto löschen'),
          content: const Text('Möchten Sie Ihr Konto wirklich löschen?' 
                              'Dies kann nicht rückgängig gemacht werden.'),
          actions: <Widget>[
            TextButton(
              onPressed: ()async {
              await  _deleteAccount();
                Navigator.of(context).pop(); 
                Navigator.popUntil(context, ModalRoute.withName('/loginpage'));
                
              },
              child: const Text('Löschen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Abbrechen'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Delete Account')),
      body: Stack(children: [
        BackroundScreen(
          ContainerGlassFlex(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/verlassen.png'),
              ),
              const Text('Account Verwaltung'),
              CustomButton(
                onTap: (){
                  deletionConfirmation(context);
                }, 
                icon: Icons.delete_rounded, 
                text: const Text('Delete Account')),
                
                    ],
                    ),
          )
        )
      ],
      ),
      
    );

  }
}