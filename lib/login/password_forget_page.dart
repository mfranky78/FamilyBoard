import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:famibo/login/login_page.dart';
import 'package:flutter/material.dart';

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
                  MaterialPageRoute(builder: (context) =>  LogInPage()),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Stack(
        children: [
          HoneycombBackground(
          child:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: 350,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 2)),
                      image: DecorationImage(  
                        image: AssetImage("assets/images/password_forget.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                   TextfieldEmail(lableText: 'E-Mail Adresse', textController: _emailController,),
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
          ),
        ],
      ),
    );
  }
}
