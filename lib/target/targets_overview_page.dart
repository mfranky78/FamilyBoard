import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_fix.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:flutter/material.dart';

class TargetOverviewPage extends StatelessWidget {
  const TargetOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Target Overview'),),
       body: Stack(
        children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/overview.png'),
              ),
              const GlassContainerFixText(child: Text('Übersicht')),
                        ],),
            )
            )
         ],
     ) );
  }
}