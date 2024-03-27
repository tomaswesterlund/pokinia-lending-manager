import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/buttons/my_fab_with_sub_title.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/util/date_extensions.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_statement_entity.dart';
import 'package:pokinia_lending_manager/presentation/pages/payments/new_open_ended_loan_payment_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan_statement/loan_statement_sliver_app_bar.dart';
import 'package:pokinia_lending_manager/presentation/widgets/payments/payment_sliver_list.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/remaining_amount_to_be_paid.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan_statement/loan_statement_page_view_model.dart';
import 'package:provider/provider.dart';

class LoanStatementPage extends StatelessWidget {
  final LoanStatementEntity loanStatement;
  const LoanStatementPage({super.key, required this.loanStatement});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanStatementPageViewModel>(
      builder: (context, vm, _) {
        return vm.getPayments(loanStatement.id).fold(
              (error) => const Text("An error occurred!"),
              (payments) => Scaffold(
                body: CustomScrollView(
                  slivers: [
                    LoanStatementAppBar(loanStatement: loanStatement),
                    SliverToBoxAdapter(child: _getDeletedWidget(loanStatement)),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const ParagraphTwoText(text: "Status"),
                              const Spacer(),
                              WidePaymentStatusBoxComponent(
                                  paymentStatus: loanStatement.paymentStatus)
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const ParagraphTwoText(text: "Expected pay date"),
                              const Spacer(),
                              ParagraphTwoText(
                                  text: loanStatement.expectedPayDate
                                      .toFormattedDate()),
                            ],
                          ),
                        ],
                      ).paddingLTRB(24.0, 24.0, 24.0, 12.0),
                    ),
                    SliverToBoxAdapter(
                      child: RemainingAmountToBePaid(
                          amount: loanStatement.remainingAmountToBePaid),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Principal paid',
                              amount: loanStatement.principalAmountPaid),
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Principal expected',
                              amount: loanStatement.expectedPrincipalAmount),
                        ],
                      ).paddingOnly(bottom: 24.0),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Interest paid',
                              amount: loanStatement.interestAmountPaid),
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Interest expected',
                              amount: loanStatement.expectedInterestAmount),
                        ],
                      ).paddingOnly(bottom: 24),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BigAmountTextWithTitleText.withPercentage(
                              title: 'Interest rate',
                              percentage: loanStatement.interestRate),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(child: 32.0.heightBox),
                    SliverToBoxAdapter(
                        child:
                            const HeaderThreeText(text: "Payments").toCenter()),
                    PaymentSliverList(payments: payments),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                      SliverToBoxAdapter(
                        child: MyFabWithSubTitle(
                          subTitle: 'Add payment',
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewOpenEndedLoanPaymentPage(loanStatementId: loanStatement.id);
                            }));
                          },
                        ),
                      ),
                    SliverToBoxAdapter(child: 48.0.heightBox),
                  ],
                ),
              ),
            );
      },
    );
  }

  Widget _getDeletedWidget(LoanStatementEntity loanStatement) {
    if (loanStatement.deleted) {
      return DeletedAlertBox(
          title: 'Loan statement has been deleted!',
          deleteDate: loanStatement.deleteDate,
          deleteReason: loanStatement.deleteReason);
    } else {
      return const SizedBox.shrink();
    }
  }
}
