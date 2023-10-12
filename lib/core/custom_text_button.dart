import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';



class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final Text text;

  const CustomTextButton({super.key, 
  required this.text, 
  required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Row(
          children: [
            GlassmorphicContainer(
              width: 250,
              height: 50,
              borderRadius: 10,
              blur: 1,
              alignment: Alignment.bottomCenter,
              border: 1,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.2),
                  const Color(0xFFFFFFFF).withOpacity(0.6),
                ],
                stops: const [0.1, 1],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.9),
                  const Color(0xFFFFFFFF).withOpacity(0.5),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [          
                    const SizedBox(width: 10),
                    text,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}