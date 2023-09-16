import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Settings'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}