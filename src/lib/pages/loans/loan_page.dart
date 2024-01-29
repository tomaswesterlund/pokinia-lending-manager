import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokinia_lending_manager/components/status_boxes/loan_payment_status/compact_loan_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_regular_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_regular_text.dart';
import 'package:pokinia_lending_manager/components/texts/percentages/big_percentage_text.dart';
import 'package:pokinia_lending_manager/components/texts/percentages/small_percentage_text.dart';
import 'package:pokinia_lending_manager/enums/loan_payment_status.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';
import 'package:pokinia_lending_manager/pages/payments/payment_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class LoanPage extends StatelessWidget {
  final String clientId;
  final String loanId;

  DateFormat dateFormat = DateFormat("MMM-dd");

  LoanPage({super.key, required this.clientId, required this.loanId});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context);
    var loanService = Provider.of<LoanService>(context);
    var paymentService = Provider.of<PaymentService>(context);

    return StreamBuilder<ClientModel>(
        stream: clientService.getClientByIdStream(clientId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var client = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: const Text("Loan page"),
              ),
              body: StreamBuilder<LoanModel>(
                stream: loanService.getLoanByIdStream(loanId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var loan = snapshot.data!;

                    return Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/dummy_avatar.png",
                                    width: 48,
                                    height: 48,
                                  ),
                                  const SizedBox(width: 16.0),

                                  // Name
                                  HeaderFourText(text: client.name),
                                ],
                              ),
                              const CompactLoanStatusBoxComponent(
                                  loanPaymentStatus: LoanPaymentStatus.unknown)
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const ParagraphOneRegularText(
                                      text: 'Remaining Principal amount'),
                                  PrimaryAmountText(amount: loan.remainingPrincipalAmount)
                                ],
                              )
                            ],
                          ),
                        ),
                        // Row -> Avatar, Name and Status
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const ParagraphOneRegularText(
                                      text: 'Int. rate'),
                                  BigPercentageText(
                                      percentage: loan.initialInterestRate),
                                ],
                              ),
                              Column(
                                children: [
                                  const ParagraphOneRegularText(
                                      text: 'Int. paid'),
                                  BigAmountText(amount: loan.interestAmountPaid)
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const ParagraphOneRegularText(
                                      text: 'Init. Pri. amount'),
                                  BigAmountText(amount: loan.initialPrincipalAmount)
                                ],
                              ),
                              Column(
                                children: [
                                  const ParagraphOneRegularText(
                                      text: 'Pri. amount paid'),
                                  BigAmountText(
                                      amount: loan.principalAmountPaid)
                                ],
                              )
                            ],
                          ),
                        ),

                        // Date - Interest rate - Interest paid - Abono - Status
                        const Padding(
                          padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ParagraphOneRegularText(text: 'Status'),
                              ParagraphOneRegularText(text: 'Date'),
                              ParagraphOneRegularText(text: 'Int. rate'),
                              ParagraphOneRegularText(text: 'Int. paid'),
                              ParagraphOneRegularText(text: 'Pri. paid'),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream:
                              paymentService.getPaymentsByLoanIdStream(loanId),
                          builder: (context, paymentsSnapshot) {
                            if (paymentsSnapshot.hasData) {
                              var payments =
                                  paymentsSnapshot.data as List<PaymentModel>;

                              return Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: payments.length,
                                  itemBuilder: (context, index) {
                                    var payment = payments[index];

                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentPage(
                                              paymentId: payment.id),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Container(
                                          color: index % 2 == 0
                                              ? const Color(0xFFF4FDFD)
                                              : Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child:
                                                      CompactPaymentStatusBox(
                                                          paymentStatus: payment
                                                              .paymentStatus),
                                                ),
                                                payment.paymentStatus ==
                                                        PaymentStatus.paid
                                                    // Choose between Expected Pay Date and Actual Pay Date
                                                    ? Expanded(
                                                        child: ParagraphTwoRegularText(
                                                            text: dateFormat
                                                                .format(payment
                                                                    .actualPayDate!)),
                                                      )
                                                    : Expanded(
                                                        child: ParagraphTwoRegularText(
                                                            text: dateFormat
                                                                .format(payment
                                                                    .expectedPayDate)),
                                                      ),
                                                Expanded(
                                                  child: SmallPercentageText(
                                                      percentage:
                                                          payment.interestRate),
                                                ),
                                                Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      child: SmallAmountText(amount: payment.interestAmountPaid),
                                                    ),
                                                  ),
                                                ),
                                                 Expanded(
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      child: SmallAmountText(amount: payment.principalAmountPaid),
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                    child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 12.0))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const Text("Loading ...");
                            }
                          },
                        ),

                        const SizedBox(height: 50)
                      ],
                    );
                  } else {
                    return const Text("ERROR OR LOADING!");
                  }
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
