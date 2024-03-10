import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/ui/components/payments/menus/delete_payment_menu_item.dart';
import 'package:pokinia_lending_manager/ui/components/payments/menus/undelete_payment_menu_item.dart';
import 'package:provider/provider.dart';

class PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String paymentId;

  const PaymentAppBar({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        var payment = provider.getById(paymentId);

        return AppBar(
          title: const Text("Payment page"),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                payment.deleted
                    ? PopupMenuItem(
                        child: UndeletePaymentMenuItem(paymentId: paymentId))
                    : PopupMenuItem(
                        child: DeletePaymentMenuItem(paymentId: paymentId)),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
