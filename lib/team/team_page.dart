import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Team'),),
       body:  Stack(
        children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/teamgroup.png'),
              ),
              const SizedBox(height: 50,),
              CustomButton(onTap: (){
                Navigator.pushNamed(context, "/teammemeber");
              }, icon: Icons.group, text: const Text('Team Memeber')),
              CustomButton(onTap: (){
                Navigator.pushNamed(context, "/imagepicker_profile");
              }, icon: Icons.groups_2, text: const Text('Team Profile')),
              CustomButton(onTap: (){
                Navigator.pushNamed(context, "/memberinvitation");
              }, icon: Icons.group_add, text: const Text('Team Invitation')),
              CustomButton(onTap: (){
                Navigator.pushNamed(context, "/teamsettings");
              }, icon: Icons.group_work, text: const Text('Team Settings')),
                        ],),
            ))
         ],
     ) );
  }
}