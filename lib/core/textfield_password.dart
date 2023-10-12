import 'package:flutter/material.dart';

class TextfieldPassword extends StatefulWidget {
  final String hintText;
  final TextEditingController textController;
  final bool isPassword;

  const TextfieldPassword({
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
          keyboardType: TextInputType.text,
          controller: widget.textController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: widget.hintText,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
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
