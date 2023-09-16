
import 'package:flutter/material.dart';

class BackroundScreen extends StatelessWidget {
 final Widget column;
   const BackroundScreen(this.column,  {super.key});

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
                    top: constraints.maxHeight * 0.5,
                    left: constraints.maxWidth * 0.10,
                    child: Container(
                      height: constraints.maxHeight * 0.55,
                      width: constraints.maxWidth * 0.45,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(89, 99, 236, 1),
                              Color.fromRGBO(84, 177, 44, 1)
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
                              Color.fromRGBO(44, 166, 177, 1)
                            ],
                            radius: 0.7,
                          ),

                          //color: Colors.red,

                          shape: BoxShape.circle),

                    )),
                    column
              ]);
            })),
      );
    
  }
}
