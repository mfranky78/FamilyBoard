import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TargetPointPage extends StatelessWidget {
  const TargetPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Target Point'),
        ),
        body: Stack(children: [
          BackroundScreen(ContainerGlassFlex(
            child: Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 250,width: 250,
                            child: Image.asset('assets/images/child.png')),
                          const Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text('Deine Punkte:',textAlign: TextAlign.center,),
                          ),
                          const GlassContainerFixText(child: Text('Deine Punkte'),),
                          const Text(
                              style: kTextHeadLine2,
                              'Behalte dein Ziel im Auge'),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircularPercentIndicator(
                              radius: 70.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: 0.7,
                              center:  const Text(
                                "70.0%",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                              footer:  const Text(
                                "Percent today",
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.green,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ))
        ]));
  }
}
