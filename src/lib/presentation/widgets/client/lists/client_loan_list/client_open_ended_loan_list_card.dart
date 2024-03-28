import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/boxes/base_box.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/loan_list/client_open_ended_loan_list_card_view_model.dart';
import 'package:provider/provider.dart';

class ClientOpenEndedLoanListCard extends StatelessWidget {
  final LoanEntity loan;

  const ClientOpenEndedLoanListCard({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientOpenEndedLoanListCardViewModel>(
      builder: (context, vm, _) {
        return vm.getOpenEndedLoanByLoanId(loan.id).fold(
              (error) => const Text("An unexpected error occurred ..."),
              (openEndedLoan) => GestureDetector(
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
                      SquaredPaymentStatusBoxComponent(
                          paymentStatus: loan.paymentStatus),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              ParagraphTwoText(
                                  text: "Type: ", color: Color(0xFF9EA6A7)),
                              ParagraphTwoText(
                                  text: "Open-ended loan",
                                  color: Color(0xFF1C2829)),
                            ],
                          ),
                          Row(
                            children: [
                              const ParagraphTwoText(
                                  text: "Status. ", color: Color(0xFF9EA6A7)),
                              ParagraphTwoText(
                                  text: loan.paymentStatus.name.capitalize(),
                                  color: const Color(0xFF1C2829)),
                            ],
                          ),
                          Row(
                            children: [
                              const ParagraphTwoText(
                                  text: "Interest rate: ",
                                  color: Color(0xFF9EA6A7)),
                              ParagraphTwoText(
                                  text: "${openEndedLoan.interestRate}%",
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
              ),
            );
      },
    );
  }
}
