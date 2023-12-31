import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:flutter/material.dart';

class TargetPage extends StatelessWidget {
  const TargetPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
    resizeToAvoidBottomInset: false,
       body:  Stack(
        children: [
          BackgroundScreen(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: ContainerGlassFlex( 
                child: Column(
                  children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop(); 
                      }, icon: const Icon(Icons.arrow_back_sharp)),
                      const SizedBox(width: 90,),
                      Text('Target',style: kTextHeadLine5)],),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/mytarget2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    ),
                ), 
                const SizedBox(height: 50,),                       
                CustomButton(onTap: (){
                  Navigator.pushNamed(context, "/targetoverview");
                }, 
                icon: Icons.tornado_rounded, 
                text:  Text('Target / Overview',style: kTextHeadLine9)),
                 CustomButton(onTap: (){
                  Navigator.pushNamed(context, "/addtarget");
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
                  text:  Text('Target Settings',style: kTextHeadLine9)),
                          ],),
              ),
            ))
         ],
     ) );
  }
}