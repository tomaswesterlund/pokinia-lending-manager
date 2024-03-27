import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/error_loan_list_card.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/boxes/base_box.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/open_ended/open_ended_loan_list_card_view_model.dart';
import 'package:provider/provider.dart';

class OpenEndedLoanListCard extends StatelessWidget {
  final String loanId;
  const OpenEndedLoanListCard({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<OpenEndedLoanListCardViewModel>(
      builder: (context, vm, _) {
        return vm.getEntities(loanId).fold(
              (error) => const ErrorLoanListCard(),
              (entities) => GestureDetector(
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
                      SquaredPaymentStatusBoxComponent(
                          paymentStatus: entities.loan.paymentStatus),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              DotPaymentStatus(
                                  paymentStatus: entities.client.paymentStatus),
                              const SizedBox(width: 5),
                              ParagraphOneText(
                                  text: entities.client.name,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          const Row(
                            children: [
                              ParagraphTwoText(
                                  text: "Type: ", color: Color(0xFF9EA6A7)),
                              ParagraphTwoText(
                                  text: "Open-ended", color: Color(0xFF1C2829)),
                            ],
                          ),
                          Row(
                            children: [
                              const ParagraphTwoText(
                                  text: "Interest rate: ",
                                  color: Color(0xFF9EA6A7)),
                              ParagraphTwoText(
                                  text:
                                      "${entities.openEndedLoan.interestRate}%",
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
                                const ParagraphTwoText(
                                    text: "Remaining principal"),
                                BigAmountText(
                                    text: entities
                                        .openEndedLoan.remainingPrincipalAmount
                                        .toFormattedCurrency())
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}
