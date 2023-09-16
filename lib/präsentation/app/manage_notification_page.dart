import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class ManageNotificationPage extends StatelessWidget {
  const ManageNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Manage Notification'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}