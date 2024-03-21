import 'package:famibo/about/terms_of_business.dart';
import 'package:famibo/features/settings/presentation/pages/settings_page.dart';
import 'package:famibo/features/settings/state/dark_mode_provider.dart';
import 'package:famibo/login/regestration_page.dart';
import 'package:famibo/settingsallgemein/delete_account.dart';
import 'package:famibo/about/privat_police.dart';
import 'package:famibo/home_screen/home_screen_page.dart';
import 'package:famibo/list_todo/list_page.dart';
import 'package:famibo/login/login_page.dart';
import 'package:famibo/login/password_forget_page.dart';
import 'package:famibo/main.dart';
import 'package:famibo/about/about_app.dart';
import 'package:famibo/features_1/my_profile/views/my_profile_page.dart';
import 'package:famibo/features_1/my_profile/my_profile_settings_page.dart';
import 'package:famibo/onboarding/logo_page.dart';
import 'package:famibo/onboarding/onboarding_page.dart';
import 'package:famibo/target/target_page.dart';
import 'package:famibo/target/target_points_page.dart';
import 'package:famibo/target/target_setting_page.dart';
import 'package:famibo/target/target_wish_page.dart';
import 'package:famibo/team/memeber_invitaion_page.dart';
import 'package:famibo/team/team_administration.dart';
import 'package:famibo/team/team_member_page.dart';
import 'package:famibo/team/team_overview.dart';
import 'package:famibo/team/team_page.dart';
import 'package:famibo/team/team_creation.dart';
import 'package:famibo/team/team_profile.dart';
import 'package:famibo/team/team_settings.dart';
import 'package:famibo/widgets/calculator.dart';
import 'package:famibo/widgets/calendar.dart';
import 'package:famibo/widgets/stundenplan.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class RoutePage extends ConsumerWidget {
  const RoutePage({super.key});

    @override
  Widget build(BuildContext context, WidgetRef ref) {
     final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark(): ThemeData.light(),
      initialRoute: "/logopage", routes: {
      
      "/loginpage": (context) =>  LogInPage(),
      "/MyApp": (context) => MyApp(),
      "/logopage": (context) => const LogoPage(),
      "/onboarding": (context) => const OnboardingPage(),
      "/homescreen": (context) =>   const HomeScreen(),
      "/myprofile": (context) =>  const MyProfilePage(),
      "/myprofilesetting": (context) => const MyProfileSettings(),
      "/calculator": (context) => const Calculator(),
      "/passwordforget": (context) => PasswordForgetPage(),
      "/targetpoint": (context) => const TargetPointPage(),
      "/addtarget": (context) => const WishPage(),
      "/targetsettings": (context) => const TargetSettingsPage(),
      "/teampage": (context) =>  const TeamPage(),
      "/teammemeber": (context) =>  const TeamMemberPage(),
      "/memberinvitation": (context) => const MemberInvitationPage(),
      "/teamsettings": (context) =>  const TeamSettingsPage(),
      "/teamcreation": (context) => TeamCreation(setImage: (String) {},),
      "/teamadmin": (context) =>  const TeamAdminPage(),
      "/mycalendar": (context) => const MyCalendar(),
      "/timetable": (context) =>  const MultipleTimetables(),
      "/listpage": (context) => const ListPage(),
      "/targetpage": (context) => const TargetPage(),
      "/aboutpage": (context) => const AboutPage(),
      "/deleteaccount": (context) =>  DeleteAccount(),
      "/privatpolice": (context) => const PrivatPolicePage(),
      "/settings": (context) =>  const SettingsPage(),
      "/termsofbusiness": (context) => const TermsOfBusiness(),
      "/regestration": (context) => const RegistrationPage(),
      "/teamprofile": (context) => TeamProfile(setImage: (String) {},),
      "/teamoverview": (context) => const TeamOverview(),
          });
  }
}
