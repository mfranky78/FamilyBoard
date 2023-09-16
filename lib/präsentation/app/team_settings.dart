import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class TeamSettingsPage extends StatelessWidget {
  const TeamSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Team Settings'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}