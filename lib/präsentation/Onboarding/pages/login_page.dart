import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/textfield_button.dart';
import 'package:famibo/pr%C3%A4sentation/Onboarding/pages/regestration_page.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BackroundScreen(
          Center(
            child: ClipRRect(
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
                          child: const Column(
                            children: [
                              TextfieldButton(
                                hintText: 'E-Mail',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextfieldButton(
                                hintText: 'Password',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: const Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ))),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            Container(
                              width: 120,
                              // margin: const EdgeInsets.only(left: 175),
                              // alignment: Alignment.centerLeft,
                              child: CustomButton(
                                selection: 'LogIn',
                                onTap: () {
                                  Navigator.pushNamed(context, "/change_page");
                                },
                                icon: Icons.login,
                                category: 'LogIn E-mail', 
                                image: const AssetImage(''),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 100,
                          width: 320,
                          child: CustomButton(
                            image: const AssetImage('assets/images/google.png'),
                            category: "Google",
                            onTap: () {
                              Navigator.pushNamed(context, "/signingoogle");
                            },
                            
                            
                            selection: 'Google',
                             icon: Icons.login,
                          ),
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
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegestrationPage())); 
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
          ),
        )
      ],
    ));
  }
}
