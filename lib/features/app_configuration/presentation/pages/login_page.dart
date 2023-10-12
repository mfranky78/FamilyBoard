import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/cutom_button_asset_image.dart';
import 'package:famibo/core/textfield_button.dart';
import 'package:famibo/core/textfield_password.dart';
import 'package:famibo/features/app_configuration/presentation/pages/screens/password_forget_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/screens/regestration_page.dart';


import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class LogInPage extends StatelessWidget {
    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
   LogInPage({super.key});



   void clickEventButton() async {
    try{
      await analytics.logEvent(
      name: 'select_content',
      parameters: {
        'content_type': 'image',
        'item_id': 1,
      },
      );
      debugPrint('Event logged');
    } catch (e) {
      debugPrint(e as String?);
    }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BackroundScreen(
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [ ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GlassmorphicContainer(
                    border: 1,
                    blur: 5,
                    borderRadius: 10,
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.85,
                    linearGradient: LinearGradient(colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.05)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderGradient: LinearGradient(colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.05)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10)),
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
                              child:  Column(
                                children: [
                                  TextfieldButton(
                                    hintText: 'E-Mail', textController: _emailController,
                                  ),
                                 
                                  TextfieldPassword(
                                    hintText: 'Password', textController: _passwordController, isPassword: true,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector( onTap: (){
                                    Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                   PasswordForgetPage()));
                                  },
                                    child: const Text(
                                      'Forgot Password ?',
                                      style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Column(
                              children: [
                                CustomButton(
                                  onTap: () {
                                    clickEventButton();
                                    Navigator.pushNamed(context, "/homescreen");
                                  },
                                  icon: Icons.login,
                                  text: const Text('LogIn'),
                                ),
                              ],
                            ),
                             const SizedBox(
                              height: 30,
                            ),
                            const Text('-----LogIn with Google Account-----', style: TextStyle(fontSize: 12),),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomImageButton(
                              image: const AssetImage('assets/images/google.png'),
                              onTap: () {
                               // Navigator.pushNamed(context, "/signingoogle");
                              },
                              text: const Text('Google'),
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
                                                  const LoginRegisterPage()));
                                    },
                                    child: const Text(
                                      'Not register yet ? Create Account',
                                      style: TextStyle(
                                          fontSize: 14,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )),
                            )
                          ],
                        )),
                  ),
                ),
                   ] ),
            ),
          ),
        )
      ],
    ));
    
  }
}
