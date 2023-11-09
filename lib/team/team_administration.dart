import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:flutter/material.dart';

class TeamAdminPage extends StatefulWidget {
   const TeamAdminPage({super.key});

  @override
  State<TeamAdminPage> createState() => _TeamAdminPageState();
}

class _TeamAdminPageState extends State<TeamAdminPage> {
 bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Administrator')),
      body: Stack(children: [
        BackroundScreen(
          ContainerGlassFlex(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
              const Row(
                children: [
                  Text('Administrator',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
              const Divider(thickness: 2,color: Colors.black,),
              const Text('Administratoren verfügen die vollständige Kontrolle über die Anwendungen und können die Mitglieder des Teams verwalten',),
              const Divider(thickness: 2,color: Colors.black,),
              const SizedBox(height: 50,),
              Image.asset('assets/images/adminVector.png'),
              const SizedBox(height: 50,),
              const Text('Team Member List', style: TextStyle(fontSize: 20),),
               Center(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const GlassContainerFixText(
                              child: Text('Team Member')),
                          Switch(
                            value: switchValue,
                            onChanged: (newValue) {
                              setState(() {
                                switchValue = newValue;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent, 
                             activeColor: Colors.grey,
                             inactiveTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                      ]),
            ),
          ))
      ],),
    );
  }
}