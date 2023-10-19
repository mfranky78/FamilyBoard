import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/textfield_button.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class PasswordForgetPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
   PasswordForgetPage({super.key});

  // Funktion zum Anzeigen des Popups
  Future<void> _showResetPasswordDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Passwort zurückgesetzt!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Du hast eine E-Mail erhalten.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Popup schließen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const LogInPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Stack(
        children: [
          BackroundScreen(
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/password_forget.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                 TextfieldButton(hintText: 'E-Mail Adresse', textController: _emailController,),
                const SizedBox(height: 160),
                CustomButton(
                  onTap: () {
                    // Hier wird das Popup aufgerufen
                    _showResetPasswordDialog(context);
                  },
                  icon: Icons.password_outlined,
                  text: const Text('Passwort zurücksetzen'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
