import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/settingsallgemein/theme_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),),
      body: Stack(children: [
        BackroundScreen(
          ContainerGlassFlex(
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/team-settings.png'),
              ),
              const SizedBox(height: 50,),
              const Text('Hier kannst du Allgemeine Einstellung machen'),
              CustomButton(onTap: (){
                Navigator.pushNamed(context, "/deleteaccount");
              }, icon: Icons.delete_rounded, text: const Text('Account Löschen')),
              CustomButton(onTap: (){
               // BlocProvider.of<ThemeCubit>(context).toggleTheme();
              
              }, icon: Icons.dark_mode_rounded, text: const Text('Dark Mode')),
            ],
                    ),
          ))
      ],) ,
    );
  }
}