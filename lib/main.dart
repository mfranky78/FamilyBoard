import 'package:famibo/pr%C3%A4sentation/Onboarding/pages/onboarding_page.dart';
import 'package:famibo/pr%C3%A4sentation/app/login_google_page.dart';
import 'package:famibo/pr%C3%A4sentation/widgets/buttonnavigation.dart';
import 'package:famibo/pr%C3%A4sentation/Onboarding/pages/login_page.dart';
import 'package:famibo/pr%C3%A4sentation/Onboarding/pages/logo_page.dart';
import 'package:famibo/pr%C3%A4sentation/app/team_profile.dart';
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
      initialRoute: "/logopage",
      routes: {
        "/change_page": (context) => const ButtonNavigation(),
        "/team_profile": (context) => const TeamProfile(),
        "/loginpage":(context) => LogInPage(),
        "/homescreen":(context) => const HomeScreen(),
        "/logopage":(context) => const LogoPage(),
        "/signingoogle":(context) => const SignInDemo(),
        "/onboarding":(context) => const OnboardingPage(),
        
        
      },
    );
  }
}
