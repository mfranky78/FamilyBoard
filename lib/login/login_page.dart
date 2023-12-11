import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/cutom_button_asset_image.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:famibo/core/textfield_password.dart';
import 'package:famibo/login/bloc_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(children: [
      BackroundScreen(Padding(
          padding: const EdgeInsets.fromLTRB(0,30,0,30),
          child: ContainerGlassFlex(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              
                Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextfieldEmail(
                        hintText: 'E-Mail',
                        textController: _controllerEmail,
                      ),
                      TextfieldPassword(
                        hintText: 'Password',
                        textController: _controllerPassword,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/passwordforget");
                        },
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Column(
                    children: [
                      CustomButton(
                        onTap: () {
                          context.read<AuthCubit>().singInWithEmailPassword(
                                _controllerEmail.text,
                                _controllerPassword.text,
                                context,
                              );
                          Navigator.pushNamed(context, "/homescreen");
                          
                        },
                        text: const Text('LogIn'),
                        icon: Icons.login,
                      ),
                    
                  
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              "Log In with Google ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
            ),
          ]),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomImageButton(
                    image: const AssetImage('assets/images/google.png'),
                    onTap: () {
                      context.read<AuthCubit>().signInWithGoogle(context);         
                      Navigator.pushReplacementNamed(context, "/homescreen");
                    },
                    text: const Text('Sign in with Google'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/regestration");
                          },
                          child: const Text(
                            'Not register yet ? Create Account',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )),
                  ),
                           ] 
                           ),
                ), 
                ],
            ),
          )
          )
          )
    ]
    )
    );
  }
}
