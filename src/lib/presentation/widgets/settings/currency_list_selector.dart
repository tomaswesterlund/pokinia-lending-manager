import 'package:flutter/cupertino.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/boxes/base_box.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/currency_list_selector_view_model.dart';
import 'package:provider/provider.dart';

class CurrencyListSelector extends StatelessWidget {
  const CurrencyListSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyListSelectorViewModel>(
      builder: (context, vm, child) {
        return vm.getAllCurrencies().fold(
          (error) {
            return const ParagraphTwoText(text: 'Could not load currencies');
          },
          (currencies) {
            return ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                var currency = currencies[index];

                return BaseBox(
                  child: Row(
                    children: [
                      HeaderFourText(text: currency.key),
                      const SizedBox(width: 10),
                      ParagraphOneText(text: currency.name),
                      const Spacer(),
                      const CupertinoSwitch(value: false, onChanged: null)
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
