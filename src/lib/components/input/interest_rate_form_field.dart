import 'package:flutter/cupertino.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';

class InterestRateFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isProcessing;

  const InterestRateFormField({super.key, required this.controller, required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          enabled: !isProcessing,
          labelText: "Interest rate",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Interest rate can't be empty";
            }

            if (value.isNotNumericOrFloating()) {
              return "Interest rate must be a number";
            }
            return null;
          },
          controller: controller),
    );
  }
}