
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';

class EmptyPaymentList extends StatelessWidget {
  const EmptyPaymentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Image.asset('assets/images/empty_list_loans.png'),
            const SizedBox(height: 25),
            const HeaderFiveText(text: "No payments"),
          ],
        ),
      );
  }
}