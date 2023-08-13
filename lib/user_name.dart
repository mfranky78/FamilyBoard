import 'package:famibo/custom_button.dart';

import 'package:flutter/material.dart';

//import 'team_profile.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar with back_arrow and setting Button
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Center(
          child: Text(
            "Username",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),

      // backroundimage

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[Color.fromARGB(255, 101, 186, 255), Colors.white],
          ),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Bienenwabe.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            //Userimage
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(35),
                ),
                Container(
                  height: 220,
                  width: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/images/foto1.jpg"),
                        fit: BoxFit.cover),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
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
                  height: 240,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.edit),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/team_profile",
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Username",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Team Admin",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            //ListView Elevatedbutton
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
                children: [
                  CustomButton(category: "Goal", onTap: () {  }, icon: Icons.flag, selection: 'Goal',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Checklist", onTap: () {  }, icon: Icons.check, selection: 'Checklist',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "My Team", onTap: () {  }, icon: Icons.group, selection: 'My Team',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Food", onTap: () {  }, icon: Icons.food_bank, selection: 'Food',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Map", onTap: () {  }, icon: Icons.map, selection: 'Map',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Contact", onTap: () {  }, icon: Icons.contacts, selection: 'Contact',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Calender", onTap: () {  }, icon: Icons.calendar_today, selection: 'Calender',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Timetable", onTap: () {  }, icon: Icons.school, selection: 'Timetable',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Money", onTap: () {  }, icon: Icons.money, selection: 'Money',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "News", onTap: () {  }, icon: Icons.newspaper, selection: 'News',),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(category: "Premium", onTap: () { 
                    Navigator.pushNamed(context, "/glass");
                   }, icon: Icons.workspace_premium, selection: 'Welcom',),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
