import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Change Password'),),
       body: const Stack(
        children: [
          HoneycombBackground(
           child: Column())
         ],
     ) );
  }
}