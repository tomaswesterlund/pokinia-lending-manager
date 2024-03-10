import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool enabled;

  const MyTextFormField(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF979797)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF979797)),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: const Color(0xFFE5EAEB),
          labelText: labelText),
    );
  }
}
