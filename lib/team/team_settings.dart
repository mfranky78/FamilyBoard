import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:flutter/material.dart';

class TeamSettingsPage extends StatefulWidget {
  const TeamSettingsPage({super.key});

  @override
  State<TeamSettingsPage> createState() => _TeamSettingsPageState();
}


class _TeamSettingsPageState extends State<TeamSettingsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BackgroundScreen(Padding(
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
          child: ContainerGlassFlex(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_sharp, size: 30)),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Team Settings',
                      style: kTextHeadLine5,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/images/team-settings.png'),
                ),
                const SizedBox(height: 50),
                CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teamprofile");
                    },
                    icon: Icons.groups_3,
                    text: Text('Team Profile', style: kTextHeadLine2)),
                CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, "/teamadmin");
                    },
                    icon: Icons.admin_panel_settings,
                    text: Text(' Team Admin rights', style: kTextHeadLine2)),
                CustomButton(
                  onTap: () {
                   Navigator.pushNamed(context, "/teamoverview");
                  },
                  icon: Icons.cancel,
                  text: Text('Team Delete', style: kTextHeadLine2),
                ),
              ],
            ),
          ),
        ))
      ],
    ));
  }
}


