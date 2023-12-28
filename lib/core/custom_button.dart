import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Text text;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Color _shadowColor = Colors.black.withOpacity(0.3);
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
          _shadowColor = Colors.white.withOpacity(0.3); // Ändern der Schattenfarbe
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
          _shadowColor = Colors.black.withOpacity(0.3); // Zurücksetzen der Schattenfarbe
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
          _shadowColor = Colors.black.withOpacity(0.5); // Zurücksetzen der Schattenfarbe
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isPressed ? Matrix4.translationValues(0, 5, 0) : Matrix4.identity(),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: _shadowColor,
                blurRadius: 3,
                offset: const Offset(5, 5),
              ),
            ],
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GlassmorphicContainer(
            width: 300,
            height: 50,
            blur: 1,
            alignment: Alignment.bottomCenter,
            border: 1,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.6),
                const Color(0xFFFFFFFF).withOpacity(0.6),
              ],
              stops: const [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.9),
                const Color(0xFFFFFFFF).withOpacity(0.9),
              ],
            ),
            borderRadius: 10,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Icon(widget.icon),
                  const SizedBox(width: 10),
                  widget.text,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
