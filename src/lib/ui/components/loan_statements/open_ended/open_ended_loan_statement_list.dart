import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';
import 'package:pokinia_lending_manager/ui/components/boxes/base_box.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/ui/pages/loan_statements/loan_statement_page.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

class OpenEndedListStatmentList extends StatelessWidget {
  final List<LoanStatement> loanStatements;
  const OpenEndedListStatmentList({super.key, required this.loanStatements});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(

      itemCount: loanStatements.length,
      itemBuilder: (context, index) {
        var loanStatement = loanStatements[index];

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
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Row(
                        children: [
                          const ParagraphTwoText(
                              text: 'Expected pay date',
                              fontWeight: FontWeight.normal),
                          SmallAmountText.withText(
                              text: loanStatement.expectedPayDate
                                  .toFormattedDate()),
                        ],
                      ),
                      Row(
                        children: [
                          const ParagraphTwoText(text: 'Principal paid'),
                          SmallAmountText.withText(
                              text: loanStatement.principalAmountPaid
                                  .toFormattedCurrency()),
                        ],
                      ),
                      Row(
                        children: [
                          const ParagraphTwoText(text: 'Paid interests'),
                          SmallAmountText.withText(
                              text: loanStatement.interestAmountPaid
                                  .toFormattedCurrency()),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              )),
        );
      },
    );
  }
}

