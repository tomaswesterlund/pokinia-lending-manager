import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/core/util/date_extensions.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/deleted_loan.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/error_loan_list_card.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/loan_app_bar.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan_statement/open_ended/open_ended_loan_statement_list.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/remaining_principal_amount.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/open_ended/open_ended_loan_page_view_model.dart';
import 'package:provider/provider.dart';

class OpenEndedLoanPage extends StatelessWidget {
  final String loanId;
  const OpenEndedLoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OpenEndedLoanPageViewModel>(
        builder: (context, vm, _) {
          return vm.getEntities(loanId).fold(
                (error) => const ErrorLoanListCard(),
                (entites) => CustomScrollView(
                  slivers: [
                    LoanAppBar(
                        loanId: loanId,
                        title: 'Open ended loan',
                        isDeleted: entites.loan.paymentStatus ==
                            PaymentStatus.deleted),
                    SliverToBoxAdapter(
                      child: DeletedLoan(loan: entites.loan),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyAvatarComponent(
                              name: entites.client.name,
                              avatarImagePath: entites.client.avatarImagePath),
                          const SizedBox(width: 16.0),

                          // Name
                          HeaderFourText(text: entites.client.name),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const ParagraphTwoText(text: "Status"),
                                const Spacer(),
                                WidePaymentStatusBoxComponent(
                                    paymentStatus: entites.loan.paymentStatus)
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const ParagraphTwoText(text: "Start date"),
                                const Spacer(),
                                ParagraphTwoText(
                                    text: entites.openEndedLoan.startDate
                                        .toFormattedDate()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    SliverToBoxAdapter(
                        child: RemainingPrincipalAmount(
                            amount: entites
                                .openEndedLoan.remainingPrincipalAmount)),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Initial principal amount',
                              amount:
                                  entites.openEndedLoan.initialPrincipalAmount),
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Principal amount paid',
                              amount:
                                  entites.openEndedLoan.principalAmountPaid),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Interest amount paid',
                              amount: entites.openEndedLoan.interestAmountPaid),
                          BigAmountTextWithTitleText.withPercentage(
                              title: 'Interest rate',
                              percentage: entites.openEndedLoan.interestRate),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    const SliverToBoxAdapter(
                        child: Center(
                            child: HeaderFourText(text: 'Loan Statements'))),
                    OpenEndedListStatmentList(
                        loanStatements: entites.loanStatements),
                    const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  ],
                ),
              );
        },
      ),
    );
  }
}
