import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/list_todo/shopping/shopping_page.dart';
import 'package:famibo/list_todo/tasks_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List'),
        ),
        body: Stack(
          children: [
            BackroundScreen(Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/foto1.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(5, 5),

                            // changes position of shadow
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ShoppingPage()));
                    },
                    icon: Icons.shop,
                    text: const Text('Shopping'),
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
                      text: const Text('Tasks')),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
