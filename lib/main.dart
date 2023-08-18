import 'package:famibo/buttonnavigation.dart';
import 'package:famibo/login_page.dart';

import 'package:famibo/team_profile.dart';
import 'package:famibo/user_name.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/loginpage",
      routes: {
        "/change_page": (context) => const ButtonNavigation(),
        "/team_profile": (context) => const TeamProfile(),
        "/loginpage":(context) => LogInPage(),
        "/username":(context) => const UserName(),
        
        
      },
    );
  }
}
