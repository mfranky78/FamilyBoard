import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
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
              child: 
              ContainerGlassFlex(
                child: Column(children: [
                Image.asset('assets/images/mytarget2.png'), 
                const SizedBox(height: 50,),                       
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(onTap: (){
                    Navigator.pushNamed(context, "/targetoverview");
                  }, 
                  icon: Icons.tornado_rounded, 
                  text: const Text('Target / Overview')),
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: CustomButton(onTap: (){
                    Navigator.pushNamed(context, "/addtarget");
                   }, 
                   icon: Icons.account_balance_rounded, 
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(onTap: (){
                      Navigator.pushNamed(context, "/targetsettings");
                    }, 
                    icon: Icons.settings,
                    text: const Text('Target Settings')),
                  ),
                          ],),
              ),
            ))
         ],
     ) );
  }
}