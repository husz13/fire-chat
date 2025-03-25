import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obscureText = false});
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final validator = ((value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  });

  CustomTextField.obscureText(
      {super.key, required this.labelText, required this.controller})
      : obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
