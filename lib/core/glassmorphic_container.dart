import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomGlassContainer extends StatelessWidget {
  final Text text;
  const CustomGlassContainer(Column column, {super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        border: 1,
        blur: 5,
        borderRadius: 10,
        height: MediaQuery.of(context).size.height * 0.8,
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
                
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold),
                  )
                ])));
  }
}
