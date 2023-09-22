import 'package:flutter/material.dart';

class TextfieldButton extends StatelessWidget {
  final String hintText;

  const TextfieldButton({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText, // Verwende den übergebenen hintText
          filled: true,
          fillColor: const Color.fromARGB(120, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
