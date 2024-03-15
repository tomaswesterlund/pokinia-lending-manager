import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/loan_statements/open_ended/open_ended_default_list_card.dart';
import 'package:pokinia_lending_manager/components/loan_statements/open_ended/open_ended_overdue_list_card.dart';
import 'package:pokinia_lending_manager/components/loan_statements/open_ended/open_ended_scheduled_list_card.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';

class OpenEndedListStatmentList extends StatelessWidget {
  final List<LoanStatement> loanStatements;
  const OpenEndedListStatmentList({super.key, required this.loanStatements});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: loanStatements.length,
      itemBuilder: (context, index) {
        var loanStatement = loanStatements[index];

        if (loanStatement.paymentStatus == PaymentStatus.scheduled) {
          return OpenEndedScheduledListCard(loanStatement: loanStatement);
        } else if(loanStatement.paymentStatus == PaymentStatus.overdue) {
          return OpenEndedOverdueListCard(loanStatement: loanStatement);
        }
        else {
          return OpenEndedDefaultListCard(loanStatement: loanStatement);
        }
      },
    );
  }
}
