import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String label;
 final TextEditingController textController;
   CustomTextField({super.key, 
  required  this.textController, required this.label,
  required InputDecoration decoration});

  @override
  State<CustomTextField> createState() => _TextfieldButtonState();
}

class _TextfieldButtonState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SizedBox(height: 55,
        child: TextField(
          controller: widget.textController,
          decoration: InputDecoration(
           labelText: widget.label,labelStyle: const TextStyle(fontSize: 14),
          
           
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
