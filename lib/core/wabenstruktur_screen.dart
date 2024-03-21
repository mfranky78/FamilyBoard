import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoneycombBackground extends StatelessWidget {
  final Widget child;
  const HoneycombBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 100, 100, 100),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/wabensoftlight.svg',
              fit: BoxFit.cover, 
            ),
          ),
          // Inhalt
          child,
        ],
      ),
    );
  }
}
