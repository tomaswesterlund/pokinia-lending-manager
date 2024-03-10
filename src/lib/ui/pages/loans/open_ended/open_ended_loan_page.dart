import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/loan_statement_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/open_ended_loan_provider.dart';
import 'package:pokinia_lending_manager/ui/components/alerts/deleted_alert.dart';
import 'package:pokinia_lending_manager/ui/components/loan_statements/open_ended/open_ended_loan_statement_list.dart';
import 'package:pokinia_lending_manager/ui/components/loans/loan_app_bar.dart';
import 'package:pokinia_lending_manager/ui/components/loans/loan_user_status_component.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class OpenEndedLoanPage extends StatelessWidget {
  final String loanId;
  const OpenEndedLoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    var clientProvider = Provider.of<ClientProvider>(context);
    var loanStatementProvider = Provider.of<LoanStatementProvider>(context);
    var loanProvider = Provider.of<LoanProvider>(context);

    return Scaffold(
      body: Consumer<OpenEndedLoanProvider>(
        builder: (context, provider, _) {
          var openEndedLoan = provider.getByLoanId(loanId);
          var loanStatements = loanStatementProvider.getByLoanId(loanId);
          var loan = loanProvider.getById(loanId);
          var client = clientProvider.getById(loan.clientId);

          return CustomScrollView(
            slivers: [
              LoanAppBar(
                  loanId: loanId,
                  title: 'Open ended loan',
                  isDeleted: loan.paymentStatus == PaymentStatus.deleted),
              SliverToBoxAdapter(child: _getDeletedWidget(loan)),
              SliverToBoxAdapter(
                  child: LoanUserStatus(client: client, loan: loan)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const ParagraphOneText(
                      text: 'Remaining principal amount',
                      fontWeight: FontWeight.bold,
                    ),
                    PrimaryAmountText(
                        text: openEndedLoan.remainingPrincipalAmount
                            .toFormattedCurrency())
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BigAmountTextWithTitleText.withAmount(
                        title: 'Initial principal amount',
                        amount: openEndedLoan.initialPrincipalAmount),
                    BigAmountTextWithTitleText.withAmount(
                        title: 'Principal amount paid',
                        amount: openEndedLoan.principalAmountPaid),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    BigAmountTextWithTitleText.withAmount(
                        title: 'Interest amount paid',
                        amount: openEndedLoan.interestAmountPaid),
                    BigAmountTextWithTitleText.withPercentage(
                        title: 'Interest rate',
                        percentage: openEndedLoan.interestRate),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const ParagraphOneText(
                            text: 'Start date',
                            fontWeight: FontWeight.bold,
                          ),
                          ParagraphOneText(
                              text: openEndedLoan.startDate.toFormattedDate()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const ParagraphOneText(
                                  text: 'Status',
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    DotPaymentStatus(
                                        paymentStatus: loan.paymentStatus),
                                    const SizedBox(width: 8),
                                    ParagraphOneText(
                                        text: loan.paymentStatus.name)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
              const SliverToBoxAdapter(
                  child:
                      Center(child: HeaderFourText(text: 'Loan Statements'))),
              OpenEndedListStatmentList(loanStatements: loanStatements),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          );
        },
      ),
    );
  }

  Widget _getDeletedWidget(Loan loan) {
    if (loan.paymentStatus == PaymentStatus.deleted) {
      return DeletedAlert(
          title: 'This loan has been deleted!',
          deleteDate: loan.deleteDate,
          deleteReason: loan.deleteReason);
    } else {
      return const SizedBox.shrink();
    }
  }
}
