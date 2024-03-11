import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/ui/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_three_text.dart';

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
                  MyAvatarComponent(
                      name: client.name,
                      avatarImagePath: client.avatarImagePath),
                  const SizedBox(width: 16.0),

                  // Name
                  HeaderFourText(text: client.name),
                ],
              ),
              const SizedBox(width: 48.0),
              Column(
                children: [
                  const ParagraphThreeText(text: "Loan payment status"),
                  const SizedBox(height: 6),
                  WidePaymentStatusBoxComponent(
                      paymentStatus: loan.paymentStatus),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
