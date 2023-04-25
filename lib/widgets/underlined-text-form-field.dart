import 'package:flutter/material.dart';

class underlinedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;

  underlinedTextFormField({
    required this.controller,
    required this.labelText,
    required this.isObscure,
  });

  @override
  State<underlinedTextFormField> createState() =>
      _underlinedTextFormFieldState();
}

class _underlinedTextFormFieldState extends State<underlinedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: true,
      obscureText: widget.isObscure,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 30,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFF0000),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFF0000),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
      ),
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 30,
      ),
    );
  }
}
