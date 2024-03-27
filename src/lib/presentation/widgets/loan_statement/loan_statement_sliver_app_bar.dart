import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_statement_entity.dart';

class LoanStatementAppBar extends StatelessWidget {
  final LoanStatementEntity loanStatement;

  const LoanStatementAppBar({super.key, required this.loanStatement});

  void _onMenuItemClicked(BuildContext context, int index) async {
    // var loanStatementProvider =
    //     Provider.of<LoanStatementProvider>(context, listen: false);

    // if (index == 0) {
    //   var response = await loanStatementProvider
    //       .calculateLoanStatementValues(loanStatementId);

    //   if (!response.succeeded) {
    //     _logger.e('_onMenuItemClicked',
    //         'Error calculating loan statement: ${response.message}');
    //     ToastService().showErrorToast(response.message);
    //   }
    // }

    // if (index == 2) {
    //   _deleteLoanStatement(context);
    // }

    // if (index == 3) {
    //   _undeleteLoanStatement(context);
    // }
  }

  void _deleteLoanStatement(BuildContext context) {
    // _logger.i('_deleteLoanStatement', 'id: $loanStatementId');

    // var loanStatementProvider =
    //     Provider.of<LoanStatementProvider>(context, listen: false);

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Delete loan statement'),
    //       content: const Text(
    //           'Are you sure you want to delete this loan statement?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(), // Close the dialog
    //           child: const Text('Cancel'),
    //         ),
    //         TextButton(
    //           onPressed: () async {
    //             // Add your deletion logic here
    //             var response = await loanStatementProvider.deleteLoanStatement(
    //                 loanStatementId,
    //                 'Deleted by user from loan statement page');

    //             if (response.succeeded) {
    //               Navigator.of(context).pop();
    //             } else {
    //               ToastService().showErrorToast(response.message);
    //             }
    //           },
    //           child: const Text('Yes'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _undeleteLoanStatement(BuildContext context) {
    // _logger.i('_undeleteLoanStatement', 'id: $loanStatementId');

    // var loanStatementProvider =
    //     Provider.of<LoanStatementProvider>(context, listen: false);

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Undelete loan statement'),
    //       content: const Text(
    //           'Are you sure you want to undelete this loan statement?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(), // Close the dialog
    //           child: const Text('Cancel'),
    //         ),
    //         TextButton(
    //           onPressed: () async {
    //             // Add your deletion logic here
    //             var response = await loanStatementProvider
    //                 .undeleteLoanStatement(loanStatementId);

    //             if (response.succeeded) {
    //               Navigator.pop(context);
    //             } else {
    //               ToastService().showErrorToast(response.message);
    //             }
    //           },
    //           child: const Text('Yes'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (loanStatement.deleted) {
      return _getAppBarWhenLoanStatementIsDeleted(context);
    } else {
      return _getAppBarWhenLoanStatementIsNotDeleted(context);
    }
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
