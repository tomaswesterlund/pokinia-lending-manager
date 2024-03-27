import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/my_text_form_field.dart';

class InterestAmountPaidFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isProcessing;

  const InterestAmountPaidFormField({super.key, required this.controller, required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          keyboardType: TextInputType.number,
          enabled: !isProcessing,
          labelText: "Interest amount paid",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Interest amount paid can't be empty";
            }

            if (value.isNotNumeric()) {
              return "Interest amount paid must be a number";
            }
            return null;
          },
          controller: controller),
    );
  }
}