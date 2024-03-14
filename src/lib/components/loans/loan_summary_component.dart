import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/percentages/big_percentage_text.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class LoanSummary extends StatelessWidget {
  final Loan loan;
  const LoanSummary({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                   const ParagraphOneText(
                      text: 'Remaining Principal amount'),
                  PrimaryAmountText(
                      text: loan.remainingPrincipalAmount.toFormattedCurrency())
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: InterestRateComponent(loan: loan)),
              Expanded(
                child: Column(
                  children: [
                     const ParagraphOneText(text: 'Interests paid'),
                    BigAmountText(
                        text: loan.interestAmountPaid.toFormattedCurrency())
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                     const ParagraphOneText(
                        text: 'Initial principal amount'),
                    BigAmountText(
                        text: loan.initialPrincipalAmount.toFormattedCurrency())
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     const ParagraphOneText(
                        text: 'Principal amount paid'),
                    BigAmountText(
                        text: loan.principalAmountPaid.toFormattedCurrency())
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class InterestRateComponent extends StatefulWidget {
  const InterestRateComponent({
    super.key,
    required this.loan,
  });

  final Loan loan;

  @override
  State<InterestRateComponent> createState() => _InterestRateComponentState();
}

class _InterestRateComponentState extends State<InterestRateComponent> {
  final TextEditingController _interestRateController = TextEditingController();
  bool _isEditing = false;

  void _editMode() {
    setState(() {
      _isEditing = true;
    });
  }

  void _save() {
    setState(() {
      try {
        var value = _interestRateController.text;

        if (value.isNotEmpty && value.isNumeric()) {
          var loanProvider = Provider.of<LoanProvider>(context, listen: false);
          var interestRate = double.parse(value);

          // loanService.recalculateLoan(widget.loan.id, interestRate);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please validate your input!"),
            ),
          );
        }

        _isEditing = false;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Some error!"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           const ParagraphOneText(text: 'Interest rate'),
          _isEditing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 48,
                      child: MyTextFormField(
                        validator: (value) {
                          return null;
                        },
                        controller: _interestRateController,
                        labelText: '',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(onPressed: _save, icon: const Icon(Icons.save))
                  ],
                )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigPercentageText(
                        percentage: widget.loan.initialInterestRate),
                    IconButton(onPressed: _editMode, icon: const Icon(Icons.edit))
                  ],
                ),
        ],
      ),
    );
  }
}
