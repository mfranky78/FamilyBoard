

import 'package:famibo/home_page.dart';
import 'package:famibo/login_register_page.dart';
import 'package:flutter/material.dart';
import 'auth.dart';


class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, 
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return HomeAuthPage();
      } else {
        return const LoginRegisterPage();
      }
      },);
  }
}