import 'package:flutter/material.dart';

class TextfieldPassword extends StatefulWidget {
  final String hintText;
   final TextEditingController textController;
  final bool isPassword;

   TextfieldPassword({
    Key? key,
    required this.hintText,
    required this.textController,
    required this.isPassword,
  }) : super(key: key);

  @override
  _TextfieldPasswordState createState() => _TextfieldPasswordState();
}

class _TextfieldPasswordState extends State<TextfieldPassword> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SizedBox(
        height: 55,
        child: TextFormField(
          controller: widget.textController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: widget.hintText,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
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
