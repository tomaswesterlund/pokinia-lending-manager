import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';

class PrincipalAmountTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isProcessing;
  
  const PrincipalAmountTextField({super.key, required this.controller, required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          keyboardType: TextInputType.number,
          enabled: !isProcessing,
          labelText: "Principal amount paid",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Principal amount paid can't be empty";
            }

            if (value.isNotNumeric()) {
              return "Principal amount paid must be a number";
            }
            return null;
          },
          controller: controller),
    );
  }
}