import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:famibo/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
          animationDuration: const Duration(seconds: 4),
          splashIconSize: 200,
            duration: 5000,
            splash: "assets/images/logotext5.png",
            nextScreen: const OnboardingPage(),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.black87));
  }
}
