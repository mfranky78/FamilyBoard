import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.grey,
      appBar: AppBar(title: const Text('About'),),
       body: const Stack(
        children: [
          WabenBackground(
            // ContainerGlassFlex(
            //   child: Column(children: [
            //   Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Image.asset('assets/images/logotext3.png'),
            //   ),
            //   const Text('Version 1.0.0'),
            //   const Text('Copyright'),
            //   const SizedBox(height: 50,),
            //   CustomButton(onTap: (){
            //     Navigator.pushNamed(context, "/termsofbusiness");
            //   }, icon: Icons.business, text: const Text('Terms of business')),
            //   CustomButton(onTap: (){
            //     Navigator.pushNamed(context, "/privatpolice");
            //   }, icon: Icons.lock, text: const Text('Privacy policy')),
             
            //             ],),
            // ))
       )],
     ) );
  }
}