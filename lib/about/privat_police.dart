import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:flutter/material.dart';

class PrivatPolicePage extends StatelessWidget {
  const PrivatPolicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Privat Police'),
        ),
        body: const Stack(
          children: [
            BackroundScreen(
              ContainerGlassFlex(
                child: ContainerGlassFlex(
                  child: Text(''),
                ),
              ),
            )
          ],
        ));
  }
}
