import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/util/date_extensions.dart';
import 'package:pokinia_lending_manager/core/util/double_extensions.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_one_text.dart';

// ignore: must_be_immutable
class BigAmountTextWithTitleText extends StatelessWidget {
  final String title;
  late String text;

  BigAmountTextWithTitleText.withAmount(
      {super.key, required this.title, required double amount}) {
    text = amount.toFormattedCurrency();
  }

  BigAmountTextWithTitleText.withDate(
      {super.key, required this.title, required DateTime date}) {
    text = date.toFormattedDate();
  }

  BigAmountTextWithTitleText.withPercentage(
      {super.key, required this.title, required double percentage}) {
    text = '${percentage.toString()}%';
  }

  BigAmountTextWithTitleText.withText(
      {super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ParagraphOneText(text: title),
          BigAmountText(text: text),
        ],
      ),
    );
  }
}
