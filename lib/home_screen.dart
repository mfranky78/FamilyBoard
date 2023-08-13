import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[Color.fromARGB(255, 101, 186, 255), Colors.white],
          ),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Bienenwabe.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
       )
    );
  }
}