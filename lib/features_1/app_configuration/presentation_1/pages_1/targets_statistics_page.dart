import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class TargetStatisticPage extends StatelessWidget {
  const TargetStatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Target Statistic'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}