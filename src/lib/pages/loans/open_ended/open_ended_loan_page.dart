import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/boxes/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/components/loan_statements/open_ended/open_ended_loan_statement_list.dart';
import 'package:pokinia_lending_manager/components/loans/loan_app_bar.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/loan_statement_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/open_ended_loan_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
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
    var userSettingsProvider = Provider.of<UserSettingsProvider>(context);
    var userSettings = userSettingsProvider.getByLoggedInUser();

    return Scaffold(
      body: Consumer<OpenEndedLoanProvider>(
        builder: (context, provider, _) {
          var openEndedLoan = provider.getByLoanId(loanId);
          var loanStatements = loanStatementProvider.getByLoanId(loanId, userSettings.showDeletedLoanStatements);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyAvatarComponent(
                        name: client.name,
                        avatarImagePath: client.avatarImagePath),
                    const SizedBox(width: 16.0),

                    // Name
                    HeaderFourText(text: client.name),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const ParagraphTwoText(text: "Status"),
                          const Spacer(),
                          WidePaymentStatusBoxComponent(
                              paymentStatus: loan.paymentStatus)
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const ParagraphTwoText(text: "Start date"),
                          const Spacer(),
                          ParagraphTwoText(
                              text: openEndedLoan.startDate.toFormattedDate()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
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
      return DeletedAlertBox(
          title: 'Loan has been deleted!',
          deleteDate: loan.deleteDate,
          deleteReason: loan.deleteReason);
    } else {
      return const SizedBox.shrink();
    }
  }
}
