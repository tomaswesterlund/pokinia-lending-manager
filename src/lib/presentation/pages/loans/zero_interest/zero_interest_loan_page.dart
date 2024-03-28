import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/pages/payments/new_zero_interest_loan_payment_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/deleted_loan.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/loan_app_bar.dart';
import 'package:pokinia_lending_manager/presentation/widgets/payments/empty_payment_list.dart';
import 'package:pokinia_lending_manager/presentation/widgets/payments/small_payment_list_card.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/buttons/my_fab_with_sub_title.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/expected_pay_date_row.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_row.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/initial_principal_amount.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/remaining_principal_amount.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/unexpected_error.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/zero_interest/zero_interest_loan_page_view_model.dart';
import 'package:provider/provider.dart';

class ZeroInterestLoanPage extends StatelessWidget {
  static String routeName = 'zero_interest_loan_page';
  final String loanId;
  const ZeroInterestLoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ZeroInterestLoanPageViewModel>(
        builder: (context, vm, _) {
          return vm.getEntities(loanId).fold(
              (error) => const UnexpectedError(),
              (entities) => CustomScrollView(
                    slivers: [
                      LoanAppBar(
                          loanId: loanId,
                          title: 'Zero-interest loan',
                          isDeleted: entities.loan.deleted),
                      SliverToBoxAdapter(
                        child: DeletedLoan(loan: entities.loan),
                      ),
                      SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyAvatarComponent(
                                      name: entities.client.name,
                                      avatarImagePath: entities.client.avatarImagePath),
                                  const SizedBox(width: 16.0),

                                  // Name
                                  HeaderFourText(text: entities.client.name),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    24.0, 24.0, 24.0, 12.0),
                                child: Column(
                                  children: [
                                    PaymentStatusRow(
                                        paymentStatus: entities.loan.paymentStatus),
                                    const SizedBox(height: 12),
                                    ExpectedPayDateRow(
                                        expectedPayDate:
                                            entities.zeroInterestLoan.expectedPayDate)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              RemainingPrincipalAmount(
                                  amount: entities.zeroInterestLoan
                                      .remainingPrincipalAmount),
                              const SizedBox(height: 16),
                              InitialPrincipalAmount(
                                  amount:
                                      entities.zeroInterestLoan.initialPrincipalAmount),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Center(child: HeaderThreeText(text: "Payments")),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      entities.payments.isEmpty
                          ? const SliverToBoxAdapter(child: EmptyPaymentList())
                          : SliverList.builder(
                              itemCount: entities.payments.length,
                              itemBuilder: (context, index) {
                                var payment = entities.payments[index];

                                return SmallPaymentListCard(
                                    payment: payment, showInterests: false);
                              },
                            ),
                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
                      SliverToBoxAdapter(
                        child: MyFabWithSubTitle(
                          subTitle: 'Add payment',
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewZeroInterestLoanPaymentPage(
                                  loanId: loanId);
                            }));
                          },
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 96)),
                    ],
                  ));
        },
      ),
    );
  }
}
