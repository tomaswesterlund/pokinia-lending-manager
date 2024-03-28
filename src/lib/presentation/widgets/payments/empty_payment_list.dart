import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_two_text.dart';

class EmptyPaymentList extends StatelessWidget {
  const EmptyPaymentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Image.asset('assets/images/empty_list_loans.png'),
        const SizedBox(height: 25),
        // const HeaderFiveText(text: "No payments were found."),
        const ParagraphTwoText(
          text: "No payments were found.",
          color: Color(0xFF1D2424),
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
