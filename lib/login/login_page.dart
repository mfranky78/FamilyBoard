import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/cutom_button_asset_image.dart';
import 'package:famibo/core/text_style_page.dart';
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
      BackgroundScreen(Padding(
          padding: const EdgeInsets.fromLTRB(0,30,0,30),
          child: ContainerGlassFlex(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'WELCOME',
                    style: kTextHeadLine1,
                  ),
                ),
              
                Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextfieldEmail(
                        lableText: 'E-Mail',
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
                        child:  Text(
                          'Forgot Password ?',
                          style: kTextHeadLine7,
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
                        text:  Text('LogIn',style: kTextHeadLine2,),
                        icon: Icons.login,
                      ),
                    
                  
                  const SizedBox(
                    height: 50,
                  ),
                   Row(children: <Widget>[
            const Expanded(
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
              style: kTextHeadLine8,
            ),
            const Expanded(
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
                    text: Text('Sign in with Google',style: kTextHeadLine2,),
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
                          child:  Text(
                            'Not register yet ? Create Account',
                            style: kTextHeadLine7,
                            ),
                          ),
                        )),
                  
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
