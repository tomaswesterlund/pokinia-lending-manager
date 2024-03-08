import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/services/loans/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class ClientZeroInterestLoanListCard extends StatelessWidget {
  final Loan loan;

  const ClientZeroInterestLoanListCard({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    var zeroInterestLoanService = Provider.of<ZeroInterestLoanService>(context);
    var zeroInterestLoan = zeroInterestLoanService.getLoanByLoanId(loan.id);

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoanPage(loan: loan))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF8F8F8),
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFFD2DEE0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SquaredPaymentStatusBoxComponent(
                        paymentStatus: loan.paymentStatus),
                    const SizedBox(width: 20),
                    BigAmountText(
                        text: zeroInterestLoan.principalAmountRemaining.toFormattedCurrency()),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
