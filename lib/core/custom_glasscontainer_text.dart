import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassContainerFixText extends StatelessWidget {
 final Widget? child;
   const GlassContainerFixText({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassmorphicContainer(
        width: 250,
        height: 50,
        borderRadius: 10,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.5),
          const Color(0xFFFFFFFF).withOpacity(0.5),
        ],
        stops: const [
          0.1,
          1,
        ]),
        borderGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFFffffff).withOpacity(0.5),
        const Color((0xFFFFFFFF)).withOpacity(0.5),
      ],
        ),
        child: Center(child: child),
      ),
    );
  }
}