import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/cutom_button_asset_image.dart';
import 'package:famibo/core/textfield_email.dart';
import 'package:famibo/core/textfield_password.dart';
import 'package:famibo/home_screen/home_screen_page.dart';
import 'package:famibo/login/bloc_cubit/auth_cubit.dart';
import 'package:famibo/login/regestration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatelessWidget {
   LogInPage({super.key});

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

 // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
        body: Stack(children: [
          BackroundScreen(Center(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(height: 800,
                    child: ContainerGlassFlex(                                            
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'WELCOME',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
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
                                        decoration:
                                            TextDecoration.underline,
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 50,
                            ),

                            
                            Column(
                              children: [
                                CustomButton(
                                  onTap:() { context
                            .read<AuthCubit>()
                            .singInWithEmailPassword(
                              _controllerEmail.text,
                              _controllerPassword.text,
                              context,
                            );
                            Navigator.pushNamed(context, "/homescreen");     
                              }, 
                              text: const Text('LogIn'), icon: Icons.login,   
                              ),


                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              '____LogIn with Google Account____',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomImageButton(
                              image: const AssetImage(
                                  'assets/images/google.png'),
                              onTap: ()  { context.read<AuthCubit>().signInWithGoogle(context);
                                
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  )); 
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                   RegistrationPage()));
                                    },
                                    child: const Text(
                                      'Not register yet ? Create Account',
                                      style: TextStyle(
                                        fontSize: 14,
                                        decoration:
                                            TextDecoration.underline,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                  ))))
        ]));
  }
}