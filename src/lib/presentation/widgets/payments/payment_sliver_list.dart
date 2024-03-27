import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/entities/payment_entity.dart';
import 'package:pokinia_lending_manager/presentation/widgets/payments/empty_payment_list.dart';
import 'package:pokinia_lending_manager/presentation/widgets/payments/small_payment_list_card.dart';

class PaymentSliverList extends StatelessWidget {
  final List<PaymentEntity> payments;
  const PaymentSliverList({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    return payments.isEmpty
        ? const SliverToBoxAdapter(child: EmptyPaymentList())
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final payment = payments[index];
                return SmallPaymentListCard(payment: payment);
              },
              childCount: payments.length,
            ),
          );
  }
}
