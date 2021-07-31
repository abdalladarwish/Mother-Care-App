import 'package:flutter/material.dart';

Widget buildTextFromField(
        {required String label,
        TextInputType keyboardType = TextInputType.text,
        bool obscureText = false,
        String? initialValue,
        TextEditingController? controller,
        ValueChanged<String>? onChanged,
        FormFieldValidator<String>? validator,
        String? hint,
        Widget? suffixIcon}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(labelText: label, hintText: hint, border: OutlineInputBorder(), suffixIcon: suffixIcon),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
      ),
    );
