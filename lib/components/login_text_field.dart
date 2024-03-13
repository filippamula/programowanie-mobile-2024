import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeHolder;
  final bool obscureText;

  const LoginTextField(
      {super.key,
      required this.controller,
      required this.placeHolder,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.white.withOpacity(0.1),
          filled: true,
          hintText: placeHolder,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
    );
  }
}
