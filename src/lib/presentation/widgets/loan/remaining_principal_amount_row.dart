import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/remaining_principal_amount_row_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/shared/unexpected_error.dart';
import 'package:provider/provider.dart';

class RemainingPrincipalAmountRow extends StatelessWidget {
  final String loanId;
  const RemainingPrincipalAmountRow({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<RemainingPrincipalAmountRowViewModel>(
      builder: (context, value, child) {
        return value.getRemainingPrincipalAmount(loanId).fold(
          (error) => const UnexpectedError(),
          (principalAmountRemaining) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ParagraphTwoText(text: "Remaining principal"),
                    BigAmountText(
                        text: principalAmountRemaining.toFormattedCurrency())
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
