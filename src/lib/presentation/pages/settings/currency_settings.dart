import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/settings/currency_list_selector.dart';

class CurrencySettings extends StatelessWidget {
  const CurrencySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency settings'),
      ),
      body: const CurrencyListSelector(),
    );
  }
}
