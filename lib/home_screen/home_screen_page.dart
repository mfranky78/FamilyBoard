import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_button_icon.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/list_todo/list_page.dart';
import 'package:famibo/login/bloc_cubit/auth_cubit.dart';
import 'package:famibo/login/bloc_cubit/auth_state.dart';
import 'package:famibo/my_profile/my_profile_page.dart';
import 'package:famibo/target/target_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state){
        if(state is Authenticated){
        return Scaffold(
           appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut(context);            
              },             
              icon: const Icon(
                Icons.logout,
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

                Text(state.email, style: kTextHeadLine1),
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
                        onTap: () {
                          Navigator.pushNamed(context, "/teampage");
                        },
                        icon: Icons.group,
                        text: const Text('Team'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {
                          
                        },
                        icon: Icons.map,
                        text: const Text('Map'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {
                          
                        },
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
    }else if (state is AuthLoading) {
      return Center(child: Text(state.message),);
      }else{
          return const Center(child: Text('Du kannst dich so nicht anmelden'));
  
    }
      },);
  }
}
  

