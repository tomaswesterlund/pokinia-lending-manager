import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/models/loan_statement.dart';

class AddPaymentModal extends StatefulWidget {
  final LoanStatement loanStatement;
  const AddPaymentModal({super.key, required this.loanStatement});

  @override
  State<AddPaymentModal> createState() => _AddPaymentModalState();
}

class _AddPaymentModalState extends State<AddPaymentModal> {

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
                      enableDrag: true,
                      isDismissible: true,
                      
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      context: context,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: const Text("NA"),
                        // child: NewPaymentPage(
                        //   clientId: widget.loanStatement.clientId,
                        //   loanId: widget.loanStatement.loanId,
                        //   loanStatementId: widget.loanStatement.id
                        // ),
                      ),
                    ),
                  }),
        ],
      ),
    );
  }
}

