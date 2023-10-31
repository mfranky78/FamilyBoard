import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ContainerGlassFlex extends StatelessWidget {
  final Widget? child; 

  const ContainerGlassFlex({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GlassmorphicFlexContainer(
        
        borderRadius: 20,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.06),
            const Color(0xFFFFFFFF).withOpacity(0.03),
          ],
          stops: const [
            0.1,
            1,
          ],
        ),
        border: 4,
        blur: 10,
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.3),
            const Color(0xFFFFFFFF).withOpacity(0.3),
          ],
        ),
        child: child, 
      ),
    );
  }
}
