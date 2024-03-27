import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/util/date_extensions.dart';

class ExpectedPayDateRow extends StatelessWidget {
  final DateTime? expectedPayDate;
  const ExpectedPayDateRow({super.key, required this.expectedPayDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ParagraphTwoText(text: "Expected pay date"),
        const Spacer(),
        ParagraphTwoText(
            text: expectedPayDate != null
                ? expectedPayDate!.toFormattedDate()
                : "None"),
      ],
    );
  }
}
