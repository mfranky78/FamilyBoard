import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_fix.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:famibo/features/settings/state/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Scaffold(
      body: Stack(
        children: [
          HoneycombBackground(
           child: ContainerGlassFlex(
           child: Column(
             children: [
               Row(
                 children: [
                   IconButton(
                     onPressed: () {
                       Navigator.of(context).pop();
                     },
                     icon: const Icon(
                       Icons.arrow_back_sharp,
                       size: 30,
                     ),
                   ),
                   const SizedBox(
                     width: 90,
                   ),
                   Text('Settings', style: kTextHeadLine5),
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Image.asset('assets/images/team-settings.png'),
               ),
               const SizedBox(
                 height: 50,
               ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36,0,0,0),
                  child: Text('Hier kannst du Allgemeine Einstellung machen', style: kTextHeadLine2),
                ),
               const SizedBox(
                 height: 50,
               ),
               CustomButton(
                   onTap: () {
                     Navigator.pushNamed(context, "/language");
                   },
                   icon: Icons.language,
                   text: const Text('Language')),
               CustomButton(
                   onTap: () {
                     Navigator.pushNamed(context, "/deleteaccount");
                   },
                   icon: Icons.delete_rounded,
                   text: const Text('Account Löschen')),
                   const SizedBox(height: 20,),
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
                   const SizedBox(width: 90,),
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
