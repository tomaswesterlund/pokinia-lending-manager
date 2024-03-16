import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/buttons/my_fab_with_sub_title.dart';
import 'package:pokinia_lending_manager/components/loans/deleted_loan.dart';
import 'package:pokinia_lending_manager/components/loans/loan_app_bar.dart';
import 'package:pokinia_lending_manager/components/payments/empty_payment_list_component.dart';
import 'package:pokinia_lending_manager/components/payments/small_payment_list_card.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/pages/payments/new_zero_interest_loan_payment_page.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/zero_interest_loan_provider.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class ZeroInterestLoanPage extends StatelessWidget {
  final String loanId;
  const ZeroInterestLoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    var clientProvider = Provider.of<ClientProvider>(context);
    var loanProvider = Provider.of<LoanProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      body: Consumer2<ZeroInterestLoanProvider, PaymentProvider>(
        builder: (context, zeroInterestLoanProvider, paymentProvider, _) {
          var zeroInterestLoan = zeroInterestLoanProvider.getByLoanId(loanId);
          var loan = loanProvider.getById(loanId);
          var client = clientProvider.getById(loan.clientId);
          var payments = paymentProvider.getByLoanId(loanId);

          return CustomScrollView(
            slivers: [
              LoanAppBar(
                  loanId: loanId,
                  title: 'Zero-interest loan',
                  isDeleted: loan.paymentStatus == PaymentStatus.deleted),
              SliverToBoxAdapter(
                child: DeletedLoan(loan: loan),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
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
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
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
                                const ParagraphTwoText(
                                    text: "Expected pay date"),
                                const Spacer(),
                                ParagraphTwoText(
                                    text:
                                        zeroInterestLoan.expectedPayDate != null
                                            ? zeroInterestLoan.expectedPayDate!
                                                .toFormattedDate()
                                            : "None"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          const ParagraphOneText(
                            text: 'Remaining principal amount',
                            fontWeight: FontWeight.bold,
                          ),
                          PrimaryAmountText(
                              text: zeroInterestLoan.principalAmountRemaining
                                  .toFormattedCurrency())
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BigAmountTextWithTitleText.withAmount(
                              title: 'Initial principal amount',
                              amount: zeroInterestLoan.initialPrincipalAmount),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Center(child: HeaderThreeText(text: "Payments")),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              payments.isEmpty
                  ? const SliverToBoxAdapter(child: EmptyPaymentList())
                  : SliverList.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        var payment = payments[index];

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
                      return NewZeroInterestLoanPaymentPage(loanId: loanId);
                    }));
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 96)),
            ],
          );
        },
      ),
    );
  }
}
