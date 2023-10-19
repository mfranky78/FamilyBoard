import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Text text;

  const CustomButton({super.key, 
    required this.onTap,
    required this.icon,      
    required this.text, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                const Color(0xFFffffff).withOpacity(0.9),
                const Color.fromARGB(255, 128, 128, 128).withOpacity(0.1),
              ],
              stops: const [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                const Color(0xFFFFFFFF).withOpacity(0.5),
              ],
            ),
            
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Icon(icon),            
                  const SizedBox(width: 10),
                  text,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
