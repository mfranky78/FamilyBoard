import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class PasswordForgetPage extends StatelessWidget {
  const PasswordForgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Forget Password'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}