import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required String labelText,
  required bool visible,
  TextInputType keyboardType = TextInputType.text,
  int? maxLength,
  int maxLines = 1,
  String? suffixText,
}) {
  Widget textField = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey),
    ),
    child: TextField(
      obscureText: visible,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: InputBorder.none,
        counterText: '',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        suffixText: suffixText,
      ),
      style: const TextStyle(fontSize: 16.0),
    ),
  );
  return textField;
}
