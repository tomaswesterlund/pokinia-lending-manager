import 'package:flutter/cupertino.dart';
import 'package:pokinia_lending_manager/ui/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';

class PrincipalAmountFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isProcessing;

  const PrincipalAmountFormField(
      {super.key, required this.controller, required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          keyboardType: TextInputType.number,
          enabled: !isProcessing,
          labelText: "Principal amount",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Principal amount can't be empty";
            }

            if (value.isNotNumeric()) {
              return "Principal amount must be a number";
            }

            double doubleValue = double.parse(value!);

            if (doubleValue <= 0) {
              return "Principal amount must be greater than 0";
            }

            return null;
          },
          controller: controller),
    );
  }
}
