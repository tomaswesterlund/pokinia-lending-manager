import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';

class RemainingPrincipalAmount extends StatelessWidget {
  final double amount;
  const RemainingPrincipalAmount({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ParagraphOneText(
          text: 'Remaining principal amount',
          fontWeight: FontWeight.bold,
        ),
        PrimaryAmountText(text: amount.toFormattedCurrency())
      ],
    );
  }
}
