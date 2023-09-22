import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

// ignore: must_be_immutable
class MainButton extends StatelessWidget {
  IconData icon;
  String category;
  VoidCallback onTap;
  MainButton({
    super.key,
    required this.icon,
    required this.category,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      selection: category,
      onTap: onTap,
      icon: icon,
      category: '', 
      image: const AssetImage('assetName'),
    
      
    );
  }
}

class CustomButton extends StatelessWidget {
  final String selection;
  final VoidCallback onTap;
  final IconData icon;
        AssetImage? image;
   CustomButton({
    super.key,
    required this.selection,
    required this.onTap,
    required this.icon,
    required String category,
    required AssetImage image,
   
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: onTap,
            child: GlassmorphicContainer(
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
                  stops: const [
                    0.1,
                    1,
                  ]),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.9),
                  const Color((0xFFFFFFFF)).withOpacity(0.5),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(icon),
                  
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Text(
                      selection,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                   
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
