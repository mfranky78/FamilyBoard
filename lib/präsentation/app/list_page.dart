import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('List'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}