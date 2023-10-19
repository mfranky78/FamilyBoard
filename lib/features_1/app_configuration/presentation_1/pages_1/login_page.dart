import 'package:famibo/auth.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/cutom_button_asset_image.dart';
import 'package:famibo/core/textfield_button.dart';
import 'package:famibo/core/textfield_password.dart';
import 'package:famibo/features_1/app_configuration/presentation_1/pages_1/screens_pages/home_screen_page.dart';
import 'package:famibo/features_1/app_configuration/presentation_1/pages_1/screens_pages/password_forget_page.dart';
import 'package:famibo/features_1/app_configuration/presentation_1/pages_1/screens_pages/regestration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  

 
  Future<void> _signInWithEmailAndPassword() async {
  final email = _controllerEmail.text;
  final password = _controllerPassword.text;
   // debugPrint('test'+email +password);
  if (email.isEmpty || password.isEmpty) {
   return _showSnackbar('Please enter both email and password.');
    
  }

  try {
    //debugPrint('test1'+email +password);
    await Auth().signInWithEmailAndPassword(email: email, password: password);
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  } on FirebaseAuthException catch (e) {
    debugPrint('Firebase Auth Error Code: ${e.code}'); 
    _showSnackbar('Login failed: ${e.message}');
  }
}

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void checkUserLoggedIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(children: [
          BackroundScreen(Center(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GlassmorphicContainer(
                          border: 1,
                          blur: 5,
                          borderRadius: 10,
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 0.85,
                          linearGradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.05)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderGradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.05)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
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
                                  child: Column(
                                    children: [
                                      TextfieldButton(
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
                                      onTap:() => _signInWithEmailAndPassword(), 
                                      icon: Icons.login,
                                      text: const Text('LogIn'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  '-----LogIn with Google Account-----',
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomImageButton(
                                  image: const AssetImage(
                                      'assets/images/google.png'),
                                  onTap: () async {
                                  await  signInWithGoogle();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const HomeScreen(),
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
                                                      const RegistrationPage()));
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
                        ),
                      ),
                    ],
                  ))))
        ]));
  }
  
  Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    debugPrint('Error signing in with Google: $e');
    // Handle the error, show a message, or perform other actions as needed.
  }
}
}



