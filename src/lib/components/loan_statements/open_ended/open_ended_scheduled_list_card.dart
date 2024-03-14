import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/boxes/base_box.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';
import 'package:pokinia_lending_manager/pages/loan_statements/loan_statement_page.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

class OpenEndedScheduledListCard extends StatelessWidget {
  LoanStatement loanStatement;
  OpenEndedScheduledListCard({super.key, required this.loanStatement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                LoanStatementPage(loanStatementId: loanStatement.id),
          ),
        );
      },
      child: BaseBox(
        child: Row(
          children: [
            SquaredPaymentStatusBoxComponent(
                paymentStatus: loanStatement.paymentStatus),
            const SizedBox(width: 18),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ParagraphTwoText(
                          text: 'Expected pay date',
                          fontWeight: FontWeight.normal),
                      SmallAmountText.withText(
                        text: loanStatement.expectedPayDate.toFormattedDate(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ParagraphTwoText(text: 'Expected principal'),
                      SmallAmountText.withText(
                          text: loanStatement.expectedPrincipalAmount
                              .toFormattedCurrency()),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ParagraphTwoText(text: 'Expected interests'),
                      SmallAmountText.withText(
                          text: loanStatement.expectedInterestAmount
                              .toFormattedCurrency()),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18)
          ],
        ),
      ),
    );
  }
}
