import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/percentages/small_percentage_text.dart';
import 'package:pokinia_lending_manager/pages/loan_statements/loan_statement_page.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class LoanStatementTable extends StatelessWidget {
  final String loanId;

  const LoanStatementTable({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanStatementService>(
        builder: (context, loanStatementService, child) {
      return Expanded(
        child: Column(
          children: [
            // Date - Interest rate - Interest paid - Abono - Status
            const Padding(
              padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ParagraphOneText(text: 'Status'),
                  ParagraphOneText(text: 'Date'),
                  ParagraphOneText(text: 'Int. rate'),
                  ParagraphOneText(text: 'Int. paid'),
                  ParagraphOneText(text: 'Pri. paid'),
                ],
              ),
            ),

            // loanStatementService.getLoanStatementsByLoanIdStream(loanId)

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: loanStatementService
                    .getLoanStatementsByLoanId(loanId)
                    .length,
                itemBuilder: (context, index) {
                  var loanStatement = loanStatementService
                      .getLoanStatementsByLoanId(loanId)[index];

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoanStatementPage(
                            loanStatementId: loanStatement.id),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        color: index % 2 == 0
                            ? const Color(0xFFF4FDFD)
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: CompactPaymentStatusBox(
                                    paymentStatus: loanStatement.paymentStatus),
                              ),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: ParagraphTwoText(
                                        text: loanStatement.expectedPayDate
                                            .toFormattedDate()),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SmallPercentageText(
                                    percentage: loanStatement.interestRate),
                              ),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: SmallAmountText(
                                        text: loanStatement.interestAmountPaid
                                            .toFormattedCurrency()),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: SmallAmountText(
                                        text: loanStatement.principalAmountPaid
                                            .toFormattedCurrency()),
                                  ),
                                ),
                              ),
                              const Expanded(
                                  child:
                                      Icon(Icons.arrow_forward_ios, size: 12.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
