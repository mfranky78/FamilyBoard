import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:flutter/material.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HoneycombBackground(
        child: ContainerGlassFlex(
          child: Column(children: [
            Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Text(
                      'About',
                      style: kTextHeadLine5,
                    ),
                  ],
                ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/images/logotext3.png'),
            ),
            const Text('Version 1.0.0'),
            const Text('Copyright'),
            const SizedBox(height: 50,),
            CustomButton(onTap: (){
              Navigator.pushNamed(context, "/termsofbusiness");
            }, icon: Icons.business, text: const Text('Terms of business')),
            CustomButton(onTap: (){
              Navigator.pushNamed(context, "/privatpolice");
            }, icon: Icons.lock, text: const Text('Privacy policy')),
          ]),
        )
      ),
    );
  }
}
