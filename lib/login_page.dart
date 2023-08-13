import 'package:famibo/custom_button.dart';
import 'package:flutter/material.dart';
//import 'package:glassmorphism/glassmorphism.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 147, 201, 244),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Herzlich Willkommen! Bitte logge dich ein!', style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bitte gib deinen Namen ein!',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, "/change_page");
              },
              category: '',
              icon: Icons.person, selection: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
