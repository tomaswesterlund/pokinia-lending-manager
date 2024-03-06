import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/pages/loans/open_ended/edit_open_ended_loan_page.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:provider/provider.dart';

class LoanAppBar extends StatelessWidget {
  final Logger _logger = getLogger('LoanAppBar');
  final String loanId;
  final String title;

  LoanAppBar({super.key, required this.loanId, this.title = 'Loan'});

  void _onMenuItemClicked(BuildContext context, int index) async {
    var loanService = Provider.of<LoanService>(context, listen: false);
    var loan = loanService.getLoanById(loanId);

    if (index == 0) {
      var response = await loanService.calculateLoanValues(loanId);

      if (!response.succeeded) {
        _logger.e('Error calculating loan: ${response.body}');
        _showErrorMessage(response.body!);
      }
    }

    if(index == 1) {
      if(loan.type == LoanTypes.openEndedLoan) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditOpenEndedLoanPage(loanId: loanId)));
      }
      
    }

    if (index == 2) {
      _deleteLoan(context);
    }

    if (index == 3) {
      _undeleteLoan(context);
    }
  }

  void _deleteLoan(BuildContext context) {
    _logger.i('_deleteLoan - id: $loanId');

    var loanService = Provider.of<LoanService>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete loan'),
          content: const Text('Are you sure you want to delete this loan?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await loanService.deleteLoan(
                    loanId, 'Deleted by user from loan page');

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

  void _undeleteLoan(BuildContext context) {
    _logger.i('_undeleteLoan - id: $loanId');

    var loanService = Provider.of<LoanService>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Undelete loan'),
          content: const Text('Are you sure you want to undelete this loan?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await loanService.undeleteLoan(loanId);

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
    return Consumer<LoanService>(
      builder: (context, loanService, _) {
        var loan = loanService.getLoanById(loanId);

        if (loan.paymentStatus == PaymentStatus.deleted) {
          return _getAppBarWhenLoanIsDeleted(context);
        } else {
          return _getAppBarWhenLoanIsNotDeleted(context);
        }
      },
    );
  }

  Widget _getAppBarWhenLoanIsNotDeleted(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
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
                        "Recalculate loan",
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
                        "Edit loan",
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
                        "Delete loan",
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

  Widget _getAppBarWhenLoanIsDeleted(BuildContext context) {
    return SliverAppBar(
      title: const Text("Loan"),
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
                        "Recalculate loan",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
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
                        "Un-delete loan",
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
