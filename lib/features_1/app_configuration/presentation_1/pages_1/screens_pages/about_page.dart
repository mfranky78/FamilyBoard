import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('About'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}