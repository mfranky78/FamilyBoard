import 'package:famibo/core/custom_button.dart';
import 'package:flutter/material.dart';

class TeamProfile extends StatelessWidget {
  const TeamProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Center(
          child: Text(
            "TeamProfile",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hier kannst du dein Profil einstellen!",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              category: "Favorit", 
              onTap: () {}, icon: Icons.favorite, selection: 'Favorit',
            ),
          ],
        ),
      ),
    );
  }
}
