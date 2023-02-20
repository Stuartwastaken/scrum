import 'package:flutter/material.dart';

class customTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final Color borderColor;
  final Color errorBorderColor;

  customTextField(
      {required this.controller,
      required this.obscure,
      required this.label,
      required this.borderColor,
      required this.errorBorderColor});

  @override
  State<customTextField> createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      autofocus: true,
      obscureText: widget.obscure,
      decoration: InputDecoration(
        labelText: widget.label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: TextStyle(
        fontFamily: "Poppins",
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
