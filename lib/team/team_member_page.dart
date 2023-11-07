import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:flutter/material.dart';

class TeamMemberPage extends StatelessWidget {
  const TeamMemberPage({super.key});
  

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
    resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Team Member'),),
       body: Stack(
        children: [
          BackroundScreen(Column(children: [
            Text('List Member', style: TextStyle(fontSize: 22),),
            CustomButton(onTap: (){
              Navigator.pushNamed(context, "/memberinvitation");
            }, icon: Icons.wallet_membership, text: const Text('Invitation')),
            CustomButton(onTap: (){}, icon: Icons.remove, text: const Text('Team Member remove')),
            CustomButton(onTap: (){}, icon: Icons.remove, text: const Text('Leaving Group')),

          ],))
         ],
     ) );
  }
}