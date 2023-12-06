import 'package:famibo/about/terms_of_business.dart';
import 'package:famibo/common/providers.dart';
import 'package:famibo/login/regestration_page.dart';
import 'package:famibo/settings/settings_view.dart';
import 'package:famibo/settings/darkmode_notifire_riverpod.dart';
import 'package:famibo/settings/delete_account.dart';
import 'package:famibo/about/privat_police.dart';
import 'package:famibo/home_screen/home_screen_page.dart';
import 'package:famibo/list_todo/list_page.dart';
import 'package:famibo/login/login_page.dart';
import 'package:famibo/login/password_forget_page.dart';
import 'package:famibo/main.dart';
import 'package:famibo/about/about_app.dart';
import 'package:famibo/my_profile/my_profile_page.dart';
import 'package:famibo/my_profile/my_profile_settings_page.dart';
import 'package:famibo/onboarding/logo_page.dart';
import 'package:famibo/onboarding/onboarding_page.dart';
import 'package:famibo/target/target_page.dart';
import 'package:famibo/target/target_points_page.dart';
import 'package:famibo/target/target_setting_page.dart';
import 'package:famibo/target/target_wish_page.dart';
import 'package:famibo/target/targets_overview_page.dart';
import 'package:famibo/team/memeber_invitaion_page.dart';
import 'package:famibo/team/team_administration.dart';
import 'package:famibo/team/team_member_page.dart';
import 'package:famibo/team/team_page.dart';
import 'package:famibo/team/team_creation.dart';
import 'package:famibo/team/team_settings.dart';
import 'package:famibo/widgets/calculator.dart';
import 'package:famibo/widgets/calendar.dart';
import 'package:famibo/widgets/stundenplan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class RoutePage extends ConsumerWidget {
  const RoutePage({super.key});

    @override
  Widget build(BuildContext context, WidgetRef ref) {
     bool isDarkMode = ref.watch(providers.settingsProvider.select((model) => model.isDarkMode));

    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark(): ThemeData.light(),
      initialRoute: "/settings", routes: {
      
      "/loginpage": (context) =>  LogInPage(),
      "/MyApp": (context) => MyApp(),
      "/logopage": (context) => const LogoPage(),
      "/onboarding": (context) => const OnboardingPage(),
      "/homescreen": (context) =>   HomeScreen(),
      "/myprofile": (context) =>  MyProfilePage(),
      "/myprofilesetting": (context) => const MyProfileSettings(),
      "/calculator": (context) => const Calculator(),
      "/passwordforget": (context) => PasswordForgetPage(),
      "/targetpoint": (context) => const TargetPointPage(),
      "/addtarget": (context) => const WishPage(),
      "/targetsettings": (context) => const TargetSettingsPage(),
      "/targetoverview": (context) => const TargetOverviewPage(),
      "/teampage": (context) =>  const TeamPage(),
      "/teammemeber": (context) =>  TeamMemberPage(),
      "/memberinvitation": (context) => const MemberInvitationPage(),
      "/teamsettings": (context) =>  TeamSettingsPage(),
      "/teamcreation": (context) => TeamCreation(setImage: (String) {},),
      "/teamadmin": (context) => const TeamAdminPage(),
      "/mycalendar": (context) => const MyCalendar(),
      "/timetable": (context) =>  const MultipleTimetables(),
      "/listpage": (context) => const ListPage(),
      "/targetpage": (context) => const TargetPage(),
      "/aboutpage": (context) => const AboutPage(),
      "/deleteaccount": (context) =>  DeleteAccount(),
      "/privatpolice": (context) => const PrivatPolicePage(),
      "/settings": (context) =>  const SettingsView(),
      "/termsofbusiness": (context) => const TermsOfBusiness(),
      "/regestration": (context) => const RegistrationPage(),
          });
  }
}
