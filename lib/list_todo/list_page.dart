import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
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
            BackgroundScreen(Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: ContainerGlassFlex(
                child: Column(
                  children: [
                    Row(children: [IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_sharp, size: 30,)),
                    const SizedBox(width: 95,),
                      Text('List',style: kTextHeadLine5),],),
                    Container(
                      height: 250,
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
                       padding: const EdgeInsets.all(16.0),
                       child: Text('Here you can view your shopping list and tasks that are still pending. ',style: kTextHeadLine2,),
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
                      text:  Text('Shopping',style: kTextHeadLine2),
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
                        text:  Text('Tasks',style: kTextHeadLine2)),
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
