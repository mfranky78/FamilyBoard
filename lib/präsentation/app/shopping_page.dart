import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Shopping'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}