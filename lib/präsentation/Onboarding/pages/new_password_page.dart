import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('New Password'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}