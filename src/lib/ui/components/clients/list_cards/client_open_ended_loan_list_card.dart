import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/open_ended_loan_provider.dart';
import 'package:pokinia_lending_manager/ui/components/boxes/base_box.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/ui/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';
import 'package:string_capitalize/string_capitalize.dart';

class ClientOpenEndedLoanListCard extends StatelessWidget {
  final String loanId;

  const ClientOpenEndedLoanListCard({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    var loanProvider = Provider.of<LoanProvider>(context, listen: false);
    var loan = loanProvider.getById(loanId);

    var openEndedLoanProvider =
        Provider.of<OpenEndedLoanProvider>(context, listen: false);
    var openEndedLoan = openEndedLoanProvider.getByLoanId(loanId);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoanPage(loanId: loan.id),
            ));
      },
      child: BaseBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SquaredPaymentStatusBoxComponent(paymentStatus: loan.paymentStatus),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    ParagraphTwoText(
                        text: "Type: ", fillColor: Color(0xFF9EA6A7)),
                    ParagraphTwoText(
                        text: "Open-ended", fillColor: Color(0xFF1C2829)),
                  ],
                ),
                Row(
                  children: [
                    const ParagraphTwoText(
                        text: "Status. ", fillColor: Color(0xFF9EA6A7)),
                    ParagraphTwoText(
                        text: loan.paymentStatus.name.capitalize(),
                        fillColor: const Color(0xFF1C2829)),
                  ],
                ),
                Row(
                  children: [
                    const ParagraphTwoText(
                        text: "Interest rate: ", fillColor: Color(0xFF9EA6A7)),
                    ParagraphTwoText(
                        text: "${openEndedLoan.interestRate}%",
                        fillColor: const Color(0xFF1C2829)),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ParagraphTwoText(text: "Remaining principal"),
                      BigAmountText(
                          text: openEndedLoan.remainingPrincipalAmount
                              .toFormattedCurrency())
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
