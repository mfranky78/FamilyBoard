import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Profile Settings'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}