import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Administration'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}