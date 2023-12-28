
import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
 final Widget column;
   const BackgroundScreen(this.column,  {super.key});

  @override
  Widget build(BuildContext context) {
    return 
       Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(101, 142, 165, 0.91),
              Color.fromRGBO(38, 223, 115, 0.296)
            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  
                Positioned(
                    top: constraints.maxHeight * 0.6,
                    left: constraints.maxWidth * -0.10,
                    child: Container(
                      height: constraints.maxHeight * 0.55,
                      width: constraints.maxWidth * 0.45,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(130, 138, 247, 1),
                              Color.fromRGBO(51, 115, 24, 1)
                            ],
                            radius: 0.7,
                          ),
                          shape: BoxShape.circle),
                    )),

                     Positioned(
                    top: constraints.maxHeight * 0.34,
                    left: constraints.maxWidth * 0.29,
                    child: Container(
                      height: constraints.maxHeight * 0.55,
                      width: constraints.maxWidth * 0.65,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(201, 205, 255, 1),
                              Color.fromRGBO(44, 57, 177, 1)
                            ],
                            radius: 0.7,
                          ),
                          shape: BoxShape.circle),
                    )),

                     Positioned(
                    top: constraints.maxHeight * 0.19,
                    left: constraints.maxWidth * 0.09,
                    child: Container(
                      height: constraints.maxHeight * 0.55,
                      width: constraints.maxWidth * 0.45,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(201, 205, 255, 1),
                              Color.fromRGBO(148, 44, 177, 1)
                            ],
                            radius: 0.7,
                          ),
                          shape: BoxShape.circle),
                    )),

                Positioned(
                    top: constraints.maxHeight * 0.85,
                    right: constraints.maxWidth * -0.10,
                    child: Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth * 0.35,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              const Color.fromARGB(255, 255, 110, 100),
                              const Color.fromARGB(255, 148, 37, 74)
                                  .withOpacity(0.5)
                            ],
                            radius: 0.7,
                          ),

                   

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
                              Color.fromRGBO(255, 201, 245, 1),
                              Color.fromRGBO(101, 110, 0, 1)
                            ],
                            radius: 0.7,
                          ),

                       

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
                              Color.fromRGBO(44, 166, 177, 1)
                            ],
                            radius: 0.7,
                          ),

                        

                          shape: BoxShape.circle),

                    )),
                    column
              ]);
            })),
      );
    
  }
}
