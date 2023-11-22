import 'package:flutter/material.dart';

class TextfieldText extends StatefulWidget {
  final String hintText;
 final TextEditingController textController;
  const TextfieldText({super.key, required this.hintText, required  this.textController});

  @override
  State<TextfieldText> createState() => _TextfieldTextState();
}

class _TextfieldTextState extends State<TextfieldText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SizedBox(height: 55,
        child: TextField(
          controller: widget.textController,
          decoration: InputDecoration(
            hintText: widget.hintText, 
           
            filled: true,
            fillColor: const Color.fromARGB(100, 255, 255, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), 
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
