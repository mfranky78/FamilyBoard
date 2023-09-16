import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class WishPage extends StatelessWidget {
  const WishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Wish'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}