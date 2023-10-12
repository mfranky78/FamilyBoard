
import 'package:famibo/features/app_configuration/presentation/pages/login_google_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/my_profile_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/my_profile_settings_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/screens/home_screen_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/team_profile.dart';
import 'package:famibo/features/app_configuration/presentation/widgets/calculator.dart';
import 'package:famibo/features/onboarding/domain/user_model.dart';
import 'package:famibo/features/onboarding/onboarding_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/login_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/logo_page.dart';
import 'package:famibo/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>("userBox");
  
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const WidgetTree(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/logopage",
      routes: {
    
        "/team_profile": (context) =>  TeamProfile(setImage: (imagePath) {},),
        "/loginpage":(context) =>  LogInPage(),
        "/MyApp":(context) => const MyApp(),
        "/logopage":(context) => const LogoPage(),
        "/signingoogle":(context) => const SignInDemo(),
        "/onboarding":(context) => const OnboardingPage(),
        "/homescreen": (context) => const HomeScreen(),
        "/myprofile": (context) => const MyProfilePage(),
        "/calculator": (context) => const Calculator(),
        "/myprofilesetting": (context) =>  MyProfileSettings(),
        
        
      },
    );
  }
}
