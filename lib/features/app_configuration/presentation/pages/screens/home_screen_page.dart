import 'package:famibo/features/app_configuration/applikation/user_model_json.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_button_icon.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/list_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/my_profile_page.dart';
import 'package:famibo/features/app_configuration/presentation/pages/target_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserListScreen()));
              },
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ))
        ],
        title: const Text(
          "Homescreen",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          BackroundScreen(
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),

                //Userimage
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      Container(
                        height: 210,
                        width: 210,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("assets/images/foto1.jpg"),
                              fit: BoxFit.cover),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(5, 5),

                              // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 215,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButtonIcon(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyProfilePage()));
                                },
                                icon: Icons.edit)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                const Text("HomeScreen", style: kTextHeadLine1),
                const Text("Team Admin", style: kTextHeadLine2),
                const SizedBox(
                  height: 20,
                ),
                //ListView Elevatedbutton
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(9),
                    children: [
                      CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TargetPage()));
                        },
                        icon: Icons.flag,
                        text: const Text('Target'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ListPage()));
                        },
                        icon: Icons.check,
                        text: const Text('Checklist'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.group,
                        text: const Text('Team'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.food_bank,
                        text: const Text('Food'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.map,
                        text: const Text('Map'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.contacts,
                        text: const Text('Contacts'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.calendar_today,
                        text: const Text('Calendar'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.school,
                        text: const Text('School'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.money,
                        text: const Text('Money'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {},
                        icon: Icons.newspaper,
                        text: const Text('Newsletter'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
