import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/open_ended_loan_provider.dart';
import 'package:pokinia_lending_manager/components/boxes/base_box.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class OpenEndedLoanListCard extends StatelessWidget {
  final String loanId;

  const OpenEndedLoanListCard({super.key, required this.loanId});


  @override
  Widget build(BuildContext context) {
    ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
    LoanProvider loanProvider = Provider.of<LoanProvider>(context, listen: false);    

    return Consumer<OpenEndedLoanProvider>(
      builder: (context, provider, _) {
        var openEndedLoan = provider.getByLoanId(loanId);
        var loan = loanProvider.getById(loanId);
        var client = clientProvider.getById(loan.clientId);
        
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoanPage(loanId: loanId),
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
                    Row(
                      children: [
                        DotPaymentStatus(paymentStatus: client.paymentStatus),
                        const SizedBox(width: 5),
                        ParagraphOneText(
                            text: client.name, fontWeight: FontWeight.bold),
                      ],
                    ),
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
                            text: "Interest rate: ",
                            fillColor: Color(0xFF9EA6A7)),
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
      },
    );
  }
}
