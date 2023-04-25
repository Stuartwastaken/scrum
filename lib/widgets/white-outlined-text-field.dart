import 'package:flutter/material.dart';

class whiteOutlinedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  whiteOutlinedTextField({
    required this.label,
    required this.controller,
  });

  @override
  State<whiteOutlinedTextField> createState() => _whiteOutlinedTextFieldState();
}

class _whiteOutlinedTextFieldState extends State<whiteOutlinedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 2.0, color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 2.0, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 2.0, color: Colors.white),
        ),
      ),
    );
  }
}
