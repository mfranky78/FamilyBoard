import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TargetPointPage extends StatefulWidget {
  const TargetPointPage({super.key});

  @override
  State<TargetPointPage> createState() => _TargetPointPageState();
}



class _TargetPointPageState extends State<TargetPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          BackgroundScreen(Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: ContainerGlassFlex(
              child: Center(
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
                            const SizedBox(width: 50,),
                        Text('Target Point', style: kTextHeadLine5),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                                height: 200,
                                child: Image.asset('assets/images/child.png')),
                            Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Text('Your Points',
                                  textAlign: TextAlign.center,
                                  style: kTextHeadLine2),
                            ),
                            GlassContainerFixText(
                              child: Text('**200**', style: kTextHeadLine5),
                            ),
                            Text(
                                style: kTextHeadLine2,
                                'keep an eye on your goals'),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularPercentIndicator(
                                radius: 70.0,
                                lineWidth: 13.0,
                                animation: true,
                                percent: 0.7,
                                center: const Text(
                                  "70.0%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                footer: const Text(
                                  "Percent today",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
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
            ),
          ))
        ]));
  }
}
