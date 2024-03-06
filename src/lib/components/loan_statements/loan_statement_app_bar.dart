import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:provider/provider.dart';

class LoanStatementAppBar extends StatelessWidget {
  final Logger _logger = getLogger('LoanStatementAppBar');
  final String loanStatementId;

  LoanStatementAppBar({super.key, required this.loanStatementId});

  void _onMenuItemClicked(BuildContext context, int index) async {
    var loanStatementService =
        Provider.of<LoanStatementService>(context, listen: false);
    if (index == 0) {
      var response = await loanStatementService
          .calculateLoanStatementValues(loanStatementId);

      if (!response.succeeded) {
        _logger.e('Error calculating loan statement: ${response.body}');
        _showErrorMessage(response.body!);
      }
    }

    if (index == 2) {
      _deleteLoanStatement(context);
    }

    if (index == 3) {
      _undeleteLoanStatement(context);
    }
  }

  void _deleteLoanStatement(BuildContext context) {
    _logger.i('_deleteLoanStatement - id: $loanStatementId');

    var loanStatementService =
        Provider.of<LoanStatementService>(context, listen: false);

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
                    loanStatementId,
                    'Deleted by user from loan statement page');

                if (response.succeeded) {
                  Navigator.of(context).pop();
                } else {
                  _showErrorMessage(response.body!);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _undeleteLoanStatement(BuildContext context) {
    _logger.i('_undeleteLoanStatement - id: $loanStatementId');

    var loanStatementService =
        Provider.of<LoanStatementService>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Undelete loan statement'),
          content: const Text(
              'Are you sure you want to undelete this loan statement?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await loanStatementService
                    .undeleteLoanStatement(loanStatementId);

                if (response.succeeded) {
                  Navigator.pop(context);
                } else {
                  _showErrorMessage(response.body!);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanStatementService>(
      builder: (context, loanStatementService, _) {
        var loanStatement =
            loanStatementService.getLoanStatementById(loanStatementId);

        if (loanStatement.paymentStatus == PaymentStatus.deleted) {
          return _getAppBarWhenLoanStatementIsDeleted(context);
        } else {
          return _getAppBarWhenLoanStatementIsNotDeleted(context);
        }
      },
    );
  }

  Widget _getAppBarWhenLoanStatementIsNotDeleted(BuildContext context) {
    return SliverAppBar(
      title: const Text("Loan Statement"),
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) => _onMenuItemClicked(context, value),
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
            const PopupMenuItem<int>(
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
          ],
        ),
      ],
    );
  }

  Widget _getAppBarWhenLoanStatementIsDeleted(BuildContext context) {
    return SliverAppBar(
      title: const Text("Loan Statement"),
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) => _onMenuItemClicked(context, value),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
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
}
