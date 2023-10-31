import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenSettingsPage extends StatelessWidget {
  const HomeScreenSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Screen Settings'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}