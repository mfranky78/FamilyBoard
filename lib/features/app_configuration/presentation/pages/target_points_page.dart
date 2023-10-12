import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class TargetPointPage extends StatelessWidget {
  const TargetPointPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Target Point'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}