import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/my_text_form_field.dart';

class DescriptionFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isProcessing;

  const DescriptionFormField(
      {super.key, required this.controller, required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          keyboardType: TextInputType.text,
          enabled: !isProcessing,
          labelText: "Description",
          validator: (value) {
            return null;
          },
          controller: controller),
    );
  }
}
