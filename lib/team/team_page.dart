import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Team'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}