import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/percentages/small_percentage_text.dart';
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';
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
    var loanStatementService =
        Provider.of<LoanStatementService>(context, listen: false);

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
          StreamBuilder(
            stream: loanStatementService.getLoanStatementsByLoanIdStream(loanId),
            builder: (context, loanStatementsSnapshot) {
              if (loanStatementsSnapshot.hasData) {
                var loanStatements =
                    loanStatementsSnapshot.data as List<LoanStatementModel>;
                loanStatements.sort(
                    (a, b) => a.expectedPayDate.compareTo(b.expectedPayDate));

                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: loanStatements.length,
                    itemBuilder: (context, index) {
                      var loanStatement = loanStatements[index];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LoanStatementPage(paymentId: loanStatement.id),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            color: index % 2 == 0
                                ? const Color(0xFFF4FDFD)
                                : Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: CompactPaymentStatusBox(
                                        paymentStatus:
                                            loanStatement.paymentStatus),
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
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 12.0))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (loanStatementsSnapshot.hasError) {
                debugPrint(loanStatementsSnapshot.error.toString());
                return const Center(child: Text('Error loading loan statements'));
              } 
              else {
                return const Text("Loading ...");
              }
            },
          ),
        ],
      ),
    );
  }
}
