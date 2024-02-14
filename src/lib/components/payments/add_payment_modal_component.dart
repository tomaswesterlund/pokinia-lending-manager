import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';
import 'package:pokinia_lending_manager/pages/payments/new_payment_page.dart';

class AddPaymentModal extends StatelessWidget {
  final LoanStatementModel loanStatement;
  const AddPaymentModal({super.key, required this.loanStatement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          MyCtaButton(
              text: "Add payment",
              onPressed: () => {
                    showMaterialModalBottomSheet(
                      enableDrag: false,
                      isDismissible: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      context: context,
                      builder: (context) => NewPaymentPage(
                        clientId: loanStatement.clientId,
                        loanId: loanStatement.loanId,
                        loanStatementId: loanStatement.id
                      ),
                    ),
                  }),
        ],
      ),
    );
  }

}

