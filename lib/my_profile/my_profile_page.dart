import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Settings',
                style: kTextHeadLine3
                ),
              ),
            
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Startseite'),
              onTap: () =>
                Navigator.pushReplacementNamed(context,"/homescreen",)
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mein Profil bearbeiten'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/myprofilesetting")
             
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator'),
              onTap: () =>
                Navigator.pushReplacementNamed(context, "/calculator")
            ),
             ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Team Profile'),
              onTap: () =>
                Navigator.pushReplacementNamed(context, "/imagepicker_profile")
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          BackroundScreen(
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      width: 200,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage("assets/images/foto1.jpg"),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    // const TextfieldButton(hintText: 'Konto ID Verifiziert: mfrank@xxx.de'),
                    // const TextfieldButton(hintText: 'E-Mail Adresse: mfrank@xxx.de'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

