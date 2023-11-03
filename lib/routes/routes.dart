import 'package:famibo/home_screen/home_screen_page.dart';
import 'package:famibo/login/login_page.dart';
import 'package:famibo/login/password_forget_page.dart';
import 'package:famibo/main.dart';
import 'package:famibo/my_profile/my_profile_page.dart';
import 'package:famibo/my_profile/my_profile_settings_page.dart';
import 'package:famibo/onboarding/logo_page.dart';
import 'package:famibo/onboarding/onboarding_page.dart';
import 'package:famibo/target/target_points_page.dart';
import 'package:famibo/target/target_wish_page.dart';
import 'package:famibo/team/team_profile_image.dart';
import 'package:famibo/widgets/calculator.dart';
import 'package:flutter/material.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      initialRoute: "/loginpage", routes: {
      "/imagepicker_profile": (context) => TeamProfileImage( setImage: (String) {},),
      "/loginpage": (context) =>  LogInPage(),
      "/MyApp": (context) => MyApp(),
      "/logopage": (context) => const LogoPage(),
      "/onboarding": (context) => const OnboardingPage(),
      "/homescreen": (context) =>  const HomeScreen(),
      "/myprofile": (context) => const MyProfilePage(),
      "/calculator": (context) => const Calculator(),
      "/myprofilesetting": (context) => MyProfileSettings(),
      "/passwordforget": (context) => PasswordForgetPage(),
      "/targetpoint": (context) => const TargetPointPage(),
      "/addtarget": (context) => const WishPage(),
    });
  }
}
