import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/settings/show_deleted_payments.dart';

class PaymentSettings extends StatelessWidget {
  const PaymentSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment settings'),
      ),
      body: Column(
        children: [
          ShowDeletedPayments(),
        ],
      ),
    );
  }
}
