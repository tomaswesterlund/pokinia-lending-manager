import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokinia_lending_manager/core/enums/loan_types.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/log_service.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/open_ended/edit_open_ended_loan_page.dart';

class LoanAppBar extends StatelessWidget {
  final LogService _logger = LogService('LoanAppBar');
  final String loanId;
  final String title;
  final bool isDeleted;

  LoanAppBar(
      {super.key,
      required this.loanId,
      required this.title,
      required this.isDeleted});

  void _onMenuItemClicked(BuildContext context, int index) async {
    var loanService = GetIt.instance<LoanService>();
    var loan = loanService.getLoanById(loanId);

    if (index == 0) {
      var response =
          await loanService.calculateLoanValues(loanId);
          
      //     .fold((error) {
      //   _logger.e(
      //       '_onMenuItemClicked', 'Error calculating loan: ${error.message}');
      //   ToastService().showErrorToast(error.message);
      // }, (success) => null);
    }

    if (index == 1) {
      if (loan.type == LoanTypes.openEndedLoan) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditOpenEndedLoanPage(loanId: loanId)));
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
    _logger.i('_deleteLoan', 'id: $loanId');

    var loanService = GetIt.instance<LoanService>();

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
                await loanService
                    .deleteLoan(loanId, 'Deleted by user from loan page');
                    // .fold(
                    //     (error) => ToastService().showErrorToast(error.message),
                    //     (success) => Navigator.pop(context));
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _undeleteLoan(BuildContext context) {
    _logger.i('_undeleteLoan', 'id: $loanId');

    var loanService = GetIt.instance<LoanService>();

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
                var response = await loanService.undeleteLoan(loanId);
                // .fold(
                //     (error) => ToastService().showErrorToast(error.message),
                //     (success) => Navigator.pop(context));
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
    if (isDeleted) {
      return _getAppBarWhenLoanIsDeleted(context);
    } else {
      return _getAppBarWhenLoanIsNotDeleted(context);
    }
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
