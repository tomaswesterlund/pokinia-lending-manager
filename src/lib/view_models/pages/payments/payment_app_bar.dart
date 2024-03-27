import 'package:flutter/material.dart';

class PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String paymentId;

  const PaymentAppBar({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context) {
   return AppBar(
          title: const Text("Payment page"),
          centerTitle: true,
          // actions: [
          //   PopupMenuButton<int>(
          //     itemBuilder: (context) => [
          //       payment.deleted
          //           ? PopupMenuItem(
          //               child: UndeletePaymentMenuItem(paymentId: paymentId))
          //           : PopupMenuItem(
          //               child: DeletePaymentMenuItem(paymentId: paymentId)),
          //     ],
          //   ),
          // ],
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}