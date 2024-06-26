import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_one_text.dart';

class InitialPrincipalAmount extends StatelessWidget {
  final double amount;
  const InitialPrincipalAmount({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {

    return  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const ParagraphOneText(text: 'Remaining principal amount'),
          BigAmountText(text: amount.toFormattedCurrency()),
        ],
      );
  }
}
