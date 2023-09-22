import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/textfield_button.dart';
import 'package:famibo/pr%C3%A4sentation/Onboarding/pages/login_page.dart';
import 'package:flutter/material.dart';

class RegestrationPage extends StatefulWidget {
  const RegestrationPage({super.key});

  @override
  State<RegestrationPage> createState() => _RegestrationPageState();
}

class _RegestrationPageState extends State<RegestrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 194, 225, 195),
          title: const Text('Regestration'),
          actions: const [Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: Icon(Icons.people),
            
          )],
        ),
        body: Stack(
          children: [
            BackroundScreen(
              ListView(
                children: [
                            Column(
                children: [
                  Container(
                      height: 200,                 
                      decoration: const BoxDecoration(
                            image: DecorationImage(
                        image: AssetImage("assets/images/regestration_image.png"),
                        fit: BoxFit.fitWidth
                      ))),
                       const TextfieldButton(hintText: 'Name'),
                       const TextfieldButton(hintText: 'Nachname'),
                       const TextfieldButton(hintText: 'Passwort vergeben'),
                       const SizedBox(height: 40,),
                  CustomButton(selection: 'Account erstellen', onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogInPage())); 
                  }, icon: Icons.account_box, category: 'Account', image: const AssetImage(''),),
                 
                ],
                
                            ),
                          ],
              ))
          ],
        ));
  }
}
