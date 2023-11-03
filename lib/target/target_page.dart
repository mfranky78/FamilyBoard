import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:flutter/material.dart';

class TargetPage extends StatelessWidget {
  const TargetPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Target'),),
       body:  Stack(
        children: [
          BackroundScreen(
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
              Image.asset('assets/images/mytarget2.png'),                        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(onTap: (){}, 
                icon: Icons.tornado_outlined, 
                text: const Text('Target / Ziele')),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: CustomButton(onTap: (){
                  Navigator.pushNamed(context, "/addtarget");
                 }, 
                 icon: Icons.tornado_outlined, 
                 text: const Text('Add Target / Ziele hinzufügen')),
               ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(onTap: (){
                    Navigator.pushNamed(context, "/targetpoint");
                  }, 
                  icon: Icons.tornado_outlined, 
                  text: const Text('Score / erreichte Punkte')),
                ),
                        ],),
            ))
         ],
     ) );
  }
}