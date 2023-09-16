import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('My Profile'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}