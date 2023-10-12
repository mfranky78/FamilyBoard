import 'package:famibo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

final TextEditingController _controllerEmail = TextEditingController();
final TextEditingController _controllerPassword = TextEditingController();

Future<void> signInWithEmailAndPassword() async {
  try {
    await Auth().signInWithEmailAndPassword(
      email: _controllerEmail.text, 
      password: _controllerPassword.text
      );
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message;
    });
  }
}
Future<void> createUserWithEmailAndPassword() async {
  try {
    await Auth().createUserWithEmailAndPassword(
      email: _controllerEmail.text, 
      password: _controllerPassword.text
      );
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message;
     
    });
  }
}
Widget _title() {
  return const Text('User Auth');
}

Widget _entryField(
  String title,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: title,
    ),
  );
}
Widget _errorMessage() {
  return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
}
Widget _submitButton() {
  return ElevatedButton(onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
   child: Text(isLogin ? 'Login' : 'Register'),
   
   );
}
Widget _loginOrRegisterButton() {
  return TextButton(onPressed: (){
    _controllerEmail.clear();
    _controllerPassword.clear();
    setState(() {
      isLogin = !isLogin;
    });
  }, child: Text(isLogin ? 'Register instead' : 'Login instead'),
  );
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(title: _title(),
),
body: Container(
  height: double.infinity,
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      _entryField('email', _controllerEmail),
      _entryField('password', _controllerPassword),
      _errorMessage(),
      _submitButton(),
      _loginOrRegisterButton(),
    ],
  ),
),
    );
  }
}