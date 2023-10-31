import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:famibo/login/regestration_page.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatelessWidget {
   final TextEditingController _emailController = TextEditingController();
   NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Password'),
        ),
        body: Stack(
          children: [
            BackroundScreen(Column(
              children: [
                Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/new_password.png"),
                            fit: BoxFit.fitWidth))),
                            const SizedBox(height: 40,),
                 TextfieldEmail(hintText: 'E-Mail Adresse', textController: _emailController,),
               
                const Padding(
                  padding: EdgeInsets.fromLTRB(20,0,0,0),
                  child: Row(
                    children: [
                      Text(
                        'Mindestens 8 Zeichen verwenden',
                        style: TextStyle(
                            fontSize: 12, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
                CustomButton(onTap: (){
                   Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()));
                }, icon: Icons.point_of_sale, text: const Text('Passwort bestätigen'))
              ],
            ))
          ],
        ));
  }
}
