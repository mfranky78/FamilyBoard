import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:famibo/core/textfield_password.dart';
import 'package:famibo/core/textfield_text.dart';
import 'package:famibo/login/bloc_cubit/auth_cubit.dart';
import 'package:famibo/user/user_firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
 const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();

final TextEditingController _controllerName = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: 
       Stack(children: [
         BackroundScreen(
           Padding(
             padding: const EdgeInsets.fromLTRB(10,80,10,20),
             child: Center(
               child: ContainerGlassFlex(
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: 
                  [
                    Title(
                    color: Colors.black, 
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('User Regestration', 
                      style: TextStyle(fontSize: 30),),
                    )),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset('assets/images/regestration_image.png'),
                    ),
                    const SizedBox(height: 40),
                     TextfieldText(
                      textController: _controllerName, 
                      hintText: 'Name',),
                    TextfieldEmail(
                      textController: _controllerEmail, 
                      hintText: 'E-Mail',),
                    TextfieldPassword(
                      hintText: 'Password', 
                      textController: _controllerPassword, 
                      isPassword: true),
                    CustomButton(
                      onTap: ()async {
                        await context
                            .read<AuthCubit>()
                            .createUserWithEmailAndPassword(
                              _controllerEmail.text,
                              _controllerPassword.text,
                              context,
                            );
                            saveUserData(name: _controllerName.text, email:_controllerEmail.text);
                           Navigator.pushNamed(context, "/loginpage"); 

                      }, 
                      icon: Icons.app_registration, 
                      text: const Text('Regestration')),
                    ]
                           ),
               ),
             ),
           ),
        ),
      ]),
    );
  }
}
