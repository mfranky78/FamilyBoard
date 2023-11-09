import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:flutter/material.dart';

class TeamSettingsPage extends StatefulWidget {
   TeamSettingsPage({super.key});

  @override
  State<TeamSettingsPage> createState() => _TeamSettingsPageState();
}

class _TeamSettingsPageState extends State<TeamSettingsPage> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Team Settings'),
        ),
        body: Stack(
          children: [
            BackroundScreen(
              ContainerGlassFlex(
                child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('assets/images/team-settings.png'),
                  ),
                  CustomButton(
                      onTap: () {
                       Navigator.pushNamed(context, "/teamprofile");
                      },
                      icon: Icons.groups_3,
                      text: const Text('Team Profile')),
                  CustomButton(
                      onTap: () {
                        
                      },
                      icon: Icons.groups_2,
                      text: const Text('Team Member')),
                  CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, "/teamadmin");
                      },
                      icon: Icons.admin_panel_settings,
                      text: const Text(' Team Admin rights')),
                  CustomButton(
                      onTap: () {},
                      icon: Icons.cancel,
                      text: const Text('Team Delete')),
                      const SizedBox(height: 50),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const GlassContainerFixText(
                            child: Text('Location permit')),
                        Switch(
                          value: switchValue,
                          onChanged: (newValue) {
                            setState(() {
                              switchValue = newValue;
                            });
                          },
                          activeTrackColor: Colors.green, 
                           activeColor: Colors.white,
                           inactiveTrackColor: Colors.grey,
                            inactiveThumbColor: Colors.black,
                        )
                      ],
                    ),
                  ),
                ],
                            ),
              ))
          ],
        ));
  }
}
