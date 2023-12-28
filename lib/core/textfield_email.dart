import 'package:flutter/material.dart';

class TextfieldEmail extends StatefulWidget {
  final String lableText;
 final TextEditingController textController;
  const TextfieldEmail({Key? key, required this.lableText, required  this.textController}) : super(key: key);

  @override
  State<TextfieldEmail> createState() => _TextfieldEmailState();
}

class _TextfieldEmailState extends State<TextfieldEmail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SizedBox(height: 55,
        child: TextFormField(
          controller: widget.textController,
          decoration: InputDecoration(
            labelStyle:
           const TextStyle(color: Colors.black54),
            labelText: widget.lableText,
          
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
