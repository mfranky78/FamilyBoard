

import 'package:famibo/login/login_page.dart';
import 'package:famibo/features_1/onboarding/logo_page.dart';
import 'package:famibo/my_profile/my_profile_page.dart';
import 'package:famibo/my_profile/my_profile_settings_page.dart';
import 'package:famibo/features_1/app_configuration/presentation_1/pages_1/screens_pages/home_screen_page.dart';
import 'package:famibo/team/team_profile_image.dart';
import 'package:famibo/features_1/app_configuration/presentation_1/widgets/calculator.dart';
import 'package:famibo/features_1/onboarding/domain/user_model.dart';
import 'package:famibo/features_1/onboarding/onboarding_page.dart';
import 'package:famibo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>("userBox");
  
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme : ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true
      ),
      
     
      home: const MyApp(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/logopage",
      routes: {
    
        "/imagepicker_profile": (context) =>  TeamProfileImage(setImage: (String) {  },),
        "/loginpage":(context) =>  const LogInPage(),
        "/MyApp":(context) => const MyApp(),
        "/logopage":(context) => const LogoPage(),
        "/onboarding":(context) => const OnboardingPage(),
        "/homescreen": (context) => const HomeScreen(),
        "/myprofile": (context) => const MyProfilePage(),
        "/calculator": (context) => const Calculator(),
        "/myprofilesetting": (context) =>  MyProfileSettings(),
        
        
      },
    );
  }
}
