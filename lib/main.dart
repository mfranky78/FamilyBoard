import 'package:famibo/change_pages.dart';
import 'package:famibo/glass.dart';
//import 'package:glassmorphism/glassmorphism.dart';
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
      initialRoute: "/login",
      routes: {
        "/change_page": (context) => const ChangePages(),
        "/team_profile": (context) => const TeamProfile(),
        "/login": (context) => const LoginPage(),
        "/username":(context) => const UserName(),
        "/glass":(context) =>  DemoApp()
        
      },
    );
  }
}
