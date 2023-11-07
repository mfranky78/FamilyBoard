import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:flutter/material.dart';

class MemberInvitationPage extends StatelessWidget {
  const MemberInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Member Invitation'),),
       body: Stack(
        children: [
          BackroundScreen(Column(children: [
            Image.asset('assets/images/invite.png'),
            CustomButton(onTap: (){}, icon: Icons.email, text: const Text('Invitation with E-mail')),
            CustomButton(onTap: (){}, icon: Icons.link, text: const Text('Invitation about Link')),
          ],))
         ],
     ) );
  }
}