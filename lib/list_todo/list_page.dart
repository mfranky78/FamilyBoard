import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:famibo/list_todo/shopping/shopping_page.dart';
import 'package:famibo/list_todo/tasks_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            HoneycombBackground(
             child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: ContainerGlassFlex(
                child: Column(
                  children: [
                    Row(children: [IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_sharp, size: 30,)),
                    const SizedBox(width: 110,),
                      Text('Liste',style: kTextHeadLine5),],),
                    Container(
                      height: 200,
                      width: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/list1.png'),
                            fit: BoxFit.contain,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                          ),
                    ),
                    const SizedBox(
                      height: 20,),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(32,0,0,0),
                       child: Text('Hier kannst du deine Einkaufsliste oder Aufgabenliste erstellen und verwalten. ',style: kTextHeadLine2,),
                     ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const ShoppingPage()));
                      },
                      icon: Icons.shop,
                      text:  Text('Einkäufe',style: kTextHeadLine2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TaskPage()));
                        },
                        icon: Icons.task,
                        text:  Text('Aufgaben',style: kTextHeadLine2)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
