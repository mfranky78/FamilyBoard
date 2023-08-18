import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(101, 142, 165, 0.91),
          Color.fromRGBO(137, 38, 223, 0.71)
        ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                    top: constraints.maxHeight * 0.5,
                    left: constraints.maxWidth * 0.10,
                    child: Container(
                      height: constraints.maxHeight * 0.55,
                      width: constraints.maxWidth * 0.45,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(52, 64, 245, 1),
                              Color.fromRGBO(44, 177, 111, 1)
                            ],
                            radius: 0.7,
                          ),

                          //color: Colors.red,

                          shape: BoxShape.circle),
                    )),
                Positioned(
                    top: constraints.maxHeight * 0.55,
                    right: constraints.maxWidth * 0.00,
                    child: Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth * 0.35,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.red,
                              const Color.fromARGB(255, 75, 22, 40)
                                  .withOpacity(0.5)
                            ],
                            radius: 0.7,
                          ),

                          // color: Colors.red,

                          shape: BoxShape.circle),
                    )),
                Positioned(
                    top: constraints.maxHeight * 0.1,
                    left: constraints.maxWidth * 0.10,
                    child: Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth * 0.35,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(245, 52, 210, 1),
                              Color.fromRGBO(166, 177, 44, 1)
                            ],
                            radius: 0.7,
                          ),

                          //color: Colors.red,

                          shape: BoxShape.circle),
                    )),
                Positioned(
                    top: constraints.maxHeight * 0.25,
                    left: constraints.maxWidth * 0.60,
                    child: Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth * 0.25,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(52, 245, 232, 1),
                              Color.fromRGBO(159, 177, 44, 1)
                            ],
                            radius: 0.7,
                          ),

                          //color: Colors.red,

                          shape: BoxShape.circle),
                    )),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GlassmorphicContainer(
                      border: 1,
                      blur: 5,
                      borderRadius: 10,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.85,
                      linearGradient: LinearGradient(colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.05)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderGradient: LinearGradient(colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.05)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'WELCOME',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(255, 97, 71, 227))),
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/change_page");
                                    },
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          )),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
