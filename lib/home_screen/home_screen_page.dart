import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/login/bloc_cubit/auth_cubit.dart';
import 'package:famibo/login/bloc_cubit/auth_state.dart';
import 'package:famibo/user/user_firebase_service.dart';
import 'package:famibo/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String? imageUrl;

  HomeScreen({super.key, this.imageUrl});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<String> getImageUrlFromFirestore() async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    var url = documentSnapshot['url'];
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            body: Stack(
              children: [
                BackgroundScreen(
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: ContainerGlassFlex(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Homescreen",
                                style: kTextHeadLine5,
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.read<AuthCubit>().signOut(context);
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FutureBuilder(
                                future: getImageUrlFromFirestore(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    String? imageUrl = snapshot.data;
                                    return imageUrl != null
                                        ? Image.network(
                                            imageUrl,
                                            height: 200,
                                            width: 300,
                                            fit: BoxFit.cover,
                                          )
                                        : SizedBox(
                                            height: 200,
                                            child: Image.asset(
                                                'assets/images/dogchild.png'));
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(state.email, style: kTextHeadLine6),
                          ),

                          FutureBuilder(
                            future: getUserData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text(
                                    'Fehler beim Laden der Benutzerdaten: ${snapshot.error}');
                              } else {
                                try {
                                  CustomUser? user = snapshot.data;
                                  if (user != null) {
                                    return Column(
                                      children: [
                                        Text(
                                          'User: ${user.name}',
                                          style: kTextHeadLine6,
                                        ),
                                        // Weitere Anzeigen für andere Benutzerdaten
                                      ],
                                    );
                                  } else {
                                    return const Text(
                                        'Benutzer nicht gefunden');
                                  }
                                } catch (error) {
                                  return Text(
                                      'Fehler beim Verarbeiten der Benutzerdaten: $error');
                                }
                              }
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          //ListView Elevatedbutton
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ListView(
                                children: [
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/myprofile");
                                    },
                                    icon: Icons.flag,
                                    text: Text(
                                      'My Profile',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/targetpage");
                                    },
                                    icon: Icons.flag,
                                    text: Text(
                                      'Target',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/listpage");
                                    },
                                    icon: Icons.check,
                                    text: Text(
                                      'Todolist',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/teampage");
                                    },
                                    icon: Icons.group,
                                    text: Text(
                                      'Team',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/mycalendar");
                                    },
                                    icon: Icons.calendar_today,
                                    text: Text(
                                      'Calendar',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/timetable");
                                    },
                                    icon: Icons.school,
                                    text: Text(
                                      'School',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/settings");
                                    },
                                    icon: Icons.settings_applications,
                                    text: Text(
                                      'Settings',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/aboutpage");
                                    },
                                    icon: Icons.account_box,
                                    text: Text(
                                      'About',
                                      style: kTextHeadLine9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is AuthLoading) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(child: Text('Du musst dich anmelden'));
        }
      },
    );
  }
}
