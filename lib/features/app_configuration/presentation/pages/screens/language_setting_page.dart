import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Language Settings'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}