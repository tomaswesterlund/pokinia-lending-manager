import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/payments/small_payment_list_card.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/loan_statement.dart';
import 'package:pokinia_lending_manager/pages/payments/new_payment_page.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class LoanStatementPage extends StatefulWidget {
  final String loanStatementId;
  const LoanStatementPage({super.key, required this.loanStatementId});

  @override
  State<LoanStatementPage> createState() => _LoanStatementPageState();
}

class _LoanStatementPageState extends State<LoanStatementPage> {
  final Logger _logger = getLogger('LoanStatementPage');

  void _deleteLoanStatement(LoanStatementService loanStatementService) {
    _logger.i('_deleteLoanStatement - id: ${widget.loanStatementId}');
    // Are you sure you want to delete?

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete loan statement'),
          content: const Text(
              'Are you sure you want to delete this loan statement?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await loanStatementService.deleteLoanStatement(
                    widget.loanStatementId,
                    'Deleted by user from loan statement page');

                if (response.succeeded) {
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(
                      msg: response.body!,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<LoanService, LoanStatementService, PaymentService>(
      builder: (context, loanService, loanStatementService, paymentService, _) {
        var loanStatement =
            loanStatementService.getLoanStatementById(widget.loanStatementId);

        var loan = loanService.getLoanById(loanStatement.id);

        var payments =
            paymentService.getPaymentsByLoanStatementId(widget.loanStatementId);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _appBar(loanStatementService, loanStatement),
              MultiSliver(
                children: [
                  Column(
                    children: [
                      _getDeletedWidget(loanStatement),
                      _getRemainingAmountWidget(loanStatement),
                      _getInfoRowsWidget(loanStatement),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Center(
                    child: HeaderFourText(text: "Payments"),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final payment = payments[index];
                        return SmallPaymentListCard(payment: payment);
                      },
                      childCount: payments.length,
                    ),
                  ),
                  const SizedBox(height: 128),
                ],
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: getDefaultFab(
            onPressed: () => showMaterialModalBottomSheet(
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
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child:
                      NewPaymentPage(loan: loan, loanStatement: loanStatement)),
            ),
          ),
        );
      },
    );
  }

  Widget _appBar(
      LoanStatementService loanStatementService, LoanStatement loanStatement) {
    return SliverAppBar(
      title: const Text("Loan Statement"),
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) async {
            if (value == 0) {
              await loanStatementService
                  .calculateLoanStatementValues(widget.loanStatementId);
            }
            if (value == 2) {
              _deleteLoanStatement(loanStatementService);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.calculate),
                      SizedBox(width: 12.0),
                      Text(
                        "Recalculate loan statement",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<int>(
              value: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 12.0),
                      Text(
                        "Edit loan statement",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            loanStatement.deleted == true
                ? const PopupMenuItem<int>(
                    value: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              "Delete loan statement",
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : const PopupMenuItem<int>(
                    value: 3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.undo,
                              color: Colors.red,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              "Un-delete loan statement",
                            )
                          ],
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ],
    );
  }

  Widget _getDeletedWidget(LoanStatement loanStatement) {
    if (loanStatement.paymentStatus == PaymentStatus.deleted) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
        child: Center(
          child: Column(
            children: [
              const HeaderFourText(
                text: "This loan statement has been deleted",
                color: Colors.red,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ParagraphTwoText(
                    text: "Delete date: ",
                    fontWeight: FontWeight.bold,
                  ),
                  ParagraphTwoText(
                      text: loanStatement.deleteDate!.toFormattedDate()),
                ],
              ),
              const ParagraphTwoText(
                text: "Delete reason: ",
                fontWeight: FontWeight.bold,
              ),
              ParagraphTwoText(text: loanStatement.deleteReason ?? ''),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _getRemainingAmountWidget(LoanStatement loanStatement) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const HeaderFourText(text: 'Remaining amount to be paid'),
              PrimaryAmountText(
                  text: loanStatement.remainingAmountToBePaid
                      .toFormattedCurrency())
            ],
          )
        ],
      ),
    );
  }

  Widget _getInfoRowsWidget(LoanStatement loanStatement) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderFiveText(
                  text: "Payment status", fontWeight: FontWeight.normal),
              Row(
                children: [
                  DotPaymentStatus(paymentStatus: loanStatement.paymentStatus),
                  const SizedBox(width: 5),
                  loanStatement.paymentStatus == PaymentStatus.deleted
                      ? ParagraphTwoText(
                          text: loanStatement.paymentStatus.name,
                          fillColor: Colors.red,
                        )
                      : ParagraphTwoText(
                          text: loanStatement.paymentStatus.name,
                        ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderFiveText(
                  text: "Interest paid / expected",
                  fontWeight: FontWeight.normal),
              SmallAmountText(
                  text:
                      "${loanStatement.interestAmountPaid.toFormattedCurrency()} / ${loanStatement.expectedInterestAmount.toFormattedCurrency()}")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderFiveText(
                  text: "Principal paid / expected",
                  fontWeight: FontWeight.normal),
              SmallAmountText(
                  text:
                      "${loanStatement.principalAmountPaid.toFormattedCurrency()} / ${loanStatement.expectedPrincipalAmount.toFormattedCurrency()}")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderFiveText(
                  text: "Interest rate", fontWeight: FontWeight.normal),
              SmallAmountText(text: "${loanStatement.interestRate}%")
            ],
          ),
        ],
      ),
    );
  }

}
