import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class RegestrationPage extends StatelessWidget {
  const RegestrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Regestration'),
          actions: const [Icon(Icons.people)],
        ),
        body: Stack(
          children: [
            BackroundScreen(Column(
              children: [
                Container(
                    height: 220,
                    width: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/regestration_image.png"),
                    ))),
              ],
            ))
          ],
        ));
  }
}
