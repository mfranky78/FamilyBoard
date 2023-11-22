import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_fix.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/settingsallgemein/darkmode_notifire_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Stack(
        children: [
          BackroundScreen(ContainerGlassFlex(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/images/team-settings.png'),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Hier kannst du Allgemeine Einstellung machen'),
                CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/deleteaccount");
                    },
                    icon: Icons.delete_rounded,
                    text: const Text('Account Löschen')),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GlassContainerFix(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(Icons.dark_mode),
                              SizedBox(width: 10,),
                              Text('Dark Mode'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40,),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        ref.read(darkModeProvider.notifier).toggleDarkMode();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
