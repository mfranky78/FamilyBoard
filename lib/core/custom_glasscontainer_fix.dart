import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassContainerFix extends StatelessWidget {
 final Widget? child;
   const GlassContainerFix({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
  width: 350,
  height: 350,
  borderRadius: 20,
  blur: 20,
  alignment: Alignment.bottomCenter,
  border: 2,
  linearGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFFffffff).withOpacity(0.1),
        const Color(0xFFFFFFFF).withOpacity(0.05),
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
  child: child,
);
  }
}