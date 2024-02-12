import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/payments/payment_list_card_component.dart';
import 'package:pokinia_lending_manager/components/payments/recent_payment_list_card_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context);
    var loanStatementService = Provider.of<LoanStatementService>(context);
    var paymentService = Provider.of<PaymentService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderTwoText(text: "Payments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: HeaderFourText(
                      text: "Overdue payments",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  _overduePayments(loanStatementService, clientService),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: HeaderFourText(
                      text: "Upcoming payments",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  _upcomingPayments(loanStatementService, clientService),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: HeaderFourText(
                      text: "Recent payments",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  _recentPayments(
                      paymentService, loanStatementService, clientService),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<LoanStatementModel>> _overduePayments(
      LoanStatementService loanStatementService, ClientService clientService) {
    return StreamBuilder(
      stream: loanStatementService.getOverdueLoanStatementsStream(),
      builder: (context, loanStatementsSnapshot) {
        if (loanStatementsSnapshot.hasError) {
          return const Center(
            child: HeaderThreeText(text: "Error loading loan statements"),
          );
        }

        if (loanStatementsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var loanStatements = loanStatementsSnapshot.data!;

        if (loanStatements.isEmpty) {
          return const Center(
            child: ParagraphOneText(text: "No overdue payments ..."),
          );
        }

        return Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: loanStatements.length,
              itemBuilder: (context, index) {
                var loanStatement = loanStatements[index];

                return StreamBuilder<ClientModel>(
                    stream: clientService
                        .getClientByIdStream(loanStatement.clientId),
                    builder: (context, clientSnapshot) {
                      if (clientSnapshot.hasError) {
                        return const Center(
                          child: HeaderThreeText(text: "Error loading client"),
                        );
                      }

                      if (clientSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var client = clientSnapshot.data!;

                      return PaymentListCard(
                          client: client, loanStatement: loanStatement);
                    });
              },
            ),
          ],
        );
      },
    );
  }

  StreamBuilder<List<LoanStatementModel>> _upcomingPayments(
      LoanStatementService loanStatementService, ClientService clientService) {
    return StreamBuilder(
      stream: loanStatementService.getUpcomingLoanStatementsStream(),
      builder: (context, loanStatementsSnapshot) {
        if (loanStatementsSnapshot.hasError) {
          return const Center(
            child: HeaderThreeText(text: "Error loading loan statements"),
          );
        }

        if (loanStatementsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var loanStatements = loanStatementsSnapshot.data!;

        if (loanStatements.isEmpty) {
          return const Center(
            child: ParagraphOneText(text: "No upcoming payments ..."),
          );
        }

        return Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: loanStatements.length,
              itemBuilder: (context, index) {
                var loanStatement = loanStatements[index];

                return StreamBuilder<ClientModel>(
                    stream: clientService
                        .getClientByIdStream(loanStatement.clientId),
                    builder: (context, clientSnapshot) {
                      if (clientSnapshot.hasError) {
                        return const Center(
                          child: HeaderThreeText(text: "Error loading client"),
                        );
                      }

                      if (clientSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var client = clientSnapshot.data!;

                      return PaymentListCard(
                          client: client, loanStatement: loanStatement);
                    });
              },
            ),
          ],
        );
      },
    );
  }

  StreamBuilder<List<PaymentModel>> _recentPayments(
      PaymentService paymentService,
      LoanStatementService loanStatementService,
      ClientService clientService) {
    return StreamBuilder(
      stream: paymentService.getRecentlyPaidPaymentsStream(),
      builder: (context, paymentsSnapshot) {
        if (paymentsSnapshot.hasError) {
          return const Center(
            child: HeaderThreeText(text: "Error loading payments"),
          );
        }

        if (paymentsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var payments = paymentsSnapshot.data!;

        if (payments.isEmpty) {
          return const Center(
            child: ParagraphOneText(text: "No recent payments ..."),
          );
        }

        return Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: payments.length,
              itemBuilder: (context, index) {
                var payment = payments[index];

                return StreamBuilder<ClientModel>(
                    stream: clientService.getClientByIdStream(payment.clientId),
                    builder: (context, clientSnapshot) {
                      if (clientSnapshot.hasError) {
                        return const Center(
                          child: HeaderThreeText(text: "Error loading client"),
                        );
                      }

                      if (clientSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var client = clientSnapshot.data!;

                      return StreamBuilder(
                          stream:
                              loanStatementService.getLoanStatementByIdStream(
                                  payment.loanStatementId),
                          builder: (context, loanStatementSnapshot) {
                            if (loanStatementSnapshot.hasError) {
                              return const Center(
                                child: HeaderThreeText(
                                    text: "Error loading loan statement"),
                              );
                            }

                            if (loanStatementSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            var loanStatement = loanStatementSnapshot.data!;

                            return RecentPaymentListCard(
                                payment: payment,
                                client: client,
                                loanStatement: loanStatement);
                          });
                    });
              },
            ),
          ],
        );
      },
    );
  }
}
