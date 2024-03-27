import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';

class RemainingAmountToBePaid extends StatelessWidget {
  final double amount;
  const RemainingAmountToBePaid({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const HeaderFourText(text: 'Remaining amount to be paid'),
            PrimaryAmountText(text: amount.toFormattedCurrency())
          ],
        )
      ],
    ).paddingLTRB(32.0, 16.0, 32.0, 32.0);
  }
}
