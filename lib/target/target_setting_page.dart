import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class TargetSettingsPage extends StatelessWidget {
  const TargetSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Target Settings'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}