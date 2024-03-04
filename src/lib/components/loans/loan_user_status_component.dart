import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';

class LoanUserStatus extends StatelessWidget {
  final Client client;
  final Loan loan;

  const LoanUserStatus({super.key, required this.client, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyAvatarComponent(client: client),
                  const SizedBox(width: 16.0),

                  // Name
                  HeaderFourText(text: client.name),
                ],
              ),
              const SizedBox(width: 48.0),
              CompactPaymentStatusBox(
                  paymentStatus: loan.paymentStatus)
            ],
          ),
        ),
      ],
    );
  }
}
