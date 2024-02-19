import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:flutter/material.dart';

class TargetPage extends StatelessWidget {
  const TargetPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
    resizeToAvoidBottomInset: false,
       body:  Stack(
        children: [
          HoneycombBackground(
           child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: ContainerGlassFlex( 
                child: Column(
                  children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop(); 
                      }, icon: const Icon(Icons.arrow_back_sharp, size: 32,)),
                      const SizedBox(width: 90,),
                      Text('Target',style: kTextHeadLine5)],),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/statistic.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    ),
                ), 
                const SizedBox(height: 50,),                       
                CustomButton(onTap: (){
                  Navigator.pushNamed(context, "/targetoverview");
                }, 
                 icon: Icons.account_balance_rounded, 
                 text:  Text('Add Wishes',style: kTextHeadLine9)),
                  CustomButton(onTap: (){
                    Navigator.pushNamed(context, "/targetpoint");
                  }, 
                  icon: Icons.tornado_outlined, 
                  text:  Text('Score / Points',style: kTextHeadLine9)),
                  CustomButton(onTap: (){
                    Navigator.pushNamed(context, "/targetsettings");
                  }, 
                  icon: Icons.settings,
                  text:  Text('ToDo Settings',style: kTextHeadLine9)),
                          ],),
              ),
            ))
         ],
     ) );
  }
}