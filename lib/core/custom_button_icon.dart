import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomButtonIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  
 

  const CustomButtonIcon({super.key, 
    required this.onTap,
    required this.icon,      
   
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          GlassmorphicContainer(
            width: 40,
            height: 40,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Icon(icon)),            
                
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
