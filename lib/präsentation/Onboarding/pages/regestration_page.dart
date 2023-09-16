import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class RegestrationPage extends StatelessWidget {
  const RegestrationPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Regestration'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}