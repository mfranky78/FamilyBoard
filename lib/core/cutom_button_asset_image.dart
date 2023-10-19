import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomImageButton extends StatelessWidget {
  final VoidCallback onTap;
  final Text text;
  AssetImage? image;

  CustomImageButton({
    super.key, 
     this.image,
    required this.onTap,
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 const Image(image: AssetImage('assets/images/google.png'),),
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
