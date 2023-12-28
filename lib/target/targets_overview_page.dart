import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:flutter/material.dart';

class TargetOverviewPage extends StatelessWidget {
  const TargetOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BackgroundScreen(Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: ContainerGlassFlex(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          size: 30,
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                    Text('Target Overview', style: kTextHeadLine5),
                    const SizedBox(height: 80,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(height: 200,
                    child: Image.asset('assets/images/overview.png')),
                ),
                const SizedBox(
                  height: 30,
                ),
                GlassContainerFixText(
                    child: Text('Übersicht', style: kTextHeadLine2)),
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
