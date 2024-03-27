import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/util/date_extensions.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/zero_interest/zero_interest_loan_list_card_view_model.dart';
import 'package:provider/provider.dart';

class ZeroInterestLoanListCard extends StatelessWidget {
  final String loanId;

  const ZeroInterestLoanListCard({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ZeroInterestLoanListCardViewModel>(
      builder: (context, vm, _) {
        var loan = vm.getLoanById(loanId).right;
        var zeroInterestLoan = vm.getZeroInterestLoanByLoanId(loanId).right;
        var client = vm.getClientById(loan.clientId).right;

        if (vm.state == States.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (vm.state == States.error) {
          return const Center(child: Text("An error occurred"));
        } else {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoanPage(loanId: loanId),
                  ));
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              // height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF8F8F8),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SquaredPaymentStatusBoxComponent(
                      paymentStatus: loan.paymentStatus),
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
                              text: "Type: ", color: Color(0xFF9EA6A7)),
                          ParagraphTwoText(
                              text: "Zero-interest loan",
                              color: Color(0xFF1C2829)),
                        ],
                      ),
                      Row(
                        children: [
                          const ParagraphTwoText(
                              text: "Expected pay date: ",
                              color: Color(0xFF9EA6A7)),
                          ParagraphTwoText(
                              text: zeroInterestLoan.expectedPayDate != null
                                  ? zeroInterestLoan.expectedPayDate!
                                      .toFormattedDate()
                                  : "N/A",
                              color: const Color(0xFF1C2829)),
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
                                text: zeroInterestLoan.remainingPrincipalAmount
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
      },
    );
  }
}
