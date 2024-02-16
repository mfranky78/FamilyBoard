import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WabenBackground extends StatelessWidget {
  const WabenBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/wabenstruktur.svg', // Pfad zu Ihrer SVG-Datei im Assets-Verzeichnis
      semanticsLabel: 'Wabenstruktur',
      // Optional: Passen Sie die Größe an, falls nötig
      width: 200,
      height: 200,
    );
  }
}
