import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_button.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
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
              ),
            ),
            body: Stack(
              children: [
                BackroundScreen(
                  ContainerGlassFlex(
                    child: Column(
                      children: [
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
                                }  else {
                                  String? imageUrl = snapshot.data;
                                  return imageUrl != null ? Image.network(
                                    imageUrl,
                                    height: 200,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ) : Image.asset('assets/images/dogchild.png');
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(state.email,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
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
                                      Text('Benutzer: ${user.name}'),
                                      // Weitere Anzeigen für andere Benutzerdaten
                                    ],
                                  );
                                } else {
                                  return const Text('Benutzer nicht gefunden');
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
                          child: ListView(
                            padding: const EdgeInsets.all(9),
                            children: [
                              CustomButton(
                                onTap: () {
                                  Navigator.pushNamed(context, "/myprofile");
                                },
                                icon: Icons.flag,
                                text: const Text('My Profile'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                onTap: () {
                                  Navigator.pushNamed(context, "/targetpage");
                                },
                                icon: Icons.flag,
                                text: const Text('Target'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                onTap: () {
                                  Navigator.pushNamed(context, "/listpage");
                                },
                                icon: Icons.check,
                                text: const Text('Todolist'),
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
                                  Navigator.pushNamed(context, "/mycalendar");
                                },
                                icon: Icons.calendar_today,
                                text: const Text('Calendar'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                onTap: () {
                                  Navigator.pushNamed(context, "/timetable");
                                },
                                icon: Icons.school,
                                text: const Text('School'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                onTap: () {
                                  Navigator.pushNamed(context, "/settings");
                                },
                                icon: Icons.settings_applications,
                                text: const Text('Settings'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                onTap: () {
                                  Navigator.pushNamed(context, "/aboutpage");
                                },
                                icon: Icons.account_box,
                                text: const Text('About'),
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
