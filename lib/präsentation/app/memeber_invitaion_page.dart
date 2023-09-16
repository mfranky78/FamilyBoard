import 'package:famibo/core/backround_screen.dart';
import 'package:flutter/material.dart';

class MemberInvitationPage extends StatelessWidget {
  const MemberInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(title: const Text('Member Invitation'),),
       body: const Stack(
        children: [
          BackroundScreen(Column())
         ],
     ) );
  }
}