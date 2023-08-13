

import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
      image: DecorationImage(
            image: AssetImage(
              "assets/images/logo.png",
            ),
            fit: BoxFit.cover,
          ),
    ),
    ),
    );
  }
}