import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/ui/components/boxes/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/ui/components/buttons/my_fab_with_sub_title.dart';
import 'package:pokinia_lending_manager/ui/components/payments/app_bars/payment_app_bar.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final String paymentId;

  const PaymentPage({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, paymentService, _) {
        var payment = paymentService.getById(paymentId);

        return Scaffold(
          appBar: PaymentAppBar(paymentId: paymentId),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        if (payment.deleted)
                          DeletedAlertBox(
                              title: 'This payment has been deleted!',
                              deleteDate: payment.deleteDate,
                              deleteReason: payment.deleteReason)
                        else
                          Column(
                            children: [
                              const ParagraphOneText(text: 'Total amount paid'),
                              PrimaryAmountText(
                                  text: (payment.interestAmountPaid +
                                          payment.principalAmountPaid)
                                      .toFormattedCurrency())
                            ],
                          )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  BigAmountTextWithTitleText.withAmount(
                      title: 'Initial principal amount',
                      amount: payment.interestAmountPaid),
                  BigAmountTextWithTitleText.withAmount(
                      title: 'Principal amount paid',
                      amount: payment.principalAmountPaid),
                ],
              ),
              const SizedBox(height: 16),
              payment.receiptImagePath.isNullOrEmpty()
                  ? Column(children: [
                    MyFabWithSubTitle(subTitle: 'Add receipt', onPressed: () {}),
                  ],)
                  : Column(
                      children: [
                        const ParagraphOneText(text: "Receipt"),
                        Image.network(
                          payment.receiptImagePath,
                          width: 200,
                          height: 200,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
