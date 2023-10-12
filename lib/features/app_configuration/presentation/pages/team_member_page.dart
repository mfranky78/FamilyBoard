import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class TeamMemberPage extends StatelessWidget {
  const TeamMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Team Member'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}