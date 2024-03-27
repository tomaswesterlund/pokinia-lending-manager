import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/expected_pay_date.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/remaining_principal_amount_row.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/loan_list/client_zero_interest_loan_list_card_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/shared/unexpected_error.dart';
import 'package:provider/provider.dart';

class ClientZeroInterestLoanListCard extends StatelessWidget {
  final String loanId;

  const ClientZeroInterestLoanListCard({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientZeroInterestLoanListCardViewModel>(
      builder: (context, vm, _) {
        return vm.getLoanById(loanId).fold(
          (error) => const UnexpectedError(),
          (loan) {
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
                                text: "Status. ", color: Color(0xFF9EA6A7)),
                            ParagraphTwoText(
                                text: loan.paymentStatus.name.capitalize(),
                                color: const Color(0xFF1C2829)),
                          ],
                        ),
                        ExpectedPayDate(loanId: loanId),
                      ],
                    ),
                    Expanded(
                      child: RemainingPrincipalAmountRow(loanId: loanId),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
