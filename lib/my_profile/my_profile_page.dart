import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_text_button.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verifyController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
   MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'), 
          actions:  [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(onTap: (){
              Navigator.pushNamed(context, "/myprofilesetting");
            },child: const Icon(Icons.settings),),
          )
          ],
        ),
        body: Stack(
          children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Column(
                children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 220,
                          width: 200,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage("assets/images/foto1.jpg"),
                                fit: BoxFit.cover),
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                        ),
                        Text('data'),
                        const SizedBox(
                          height: 20,
                        ),
                         TextfieldEmail(
                            hintText: 'Konto ID Verifizieren', textController: _verifyController,),
                         TextfieldEmail(
                            hintText: 'E-Mail Adresse eingeben', textController: _emailController,),
                              TextfieldEmail(
                            hintText: 'Name eingeben', textController: _textController,),
                              TextfieldEmail(
                            hintText: 'Geburtsdatum eingeben', textController: _dateTimeController,),
                            const SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextButton(text: const Text('Bestätigen'), onTap: (){}),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        ]));
  }
}
