import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/boxes/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/components/images/image_picker.dart';
import 'package:pokinia_lending_manager/components/payments/app_bars/payment_app_bar.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/data/payment.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/receipt_service.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final String paymentId;

  const PaymentPage({super.key, required this.paymentId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Logger _logger = getLogger('PaymentPage');
  bool isProcessing = false;

  void _uploadImageAndUpdateReceiptImageUrl(
      PaymentProvider provider, File file) async {
    try {
      setProcessing(true);

      var receiptImageUrl = await ReceiptService().uploadReceipt(file);
      provider.updateReceiptImageUrl(widget.paymentId, receiptImageUrl);

      setProcessing(false);
    } catch (e) {
      _logger.e(e);
      setProcessing(false);
    }
  }

  void setProcessing(bool newValue) {
    setState(() {
      isProcessing = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, paymentProvider, _) {
        var payment = paymentProvider.getById(widget.paymentId);

        return Scaffold(
          appBar: PaymentAppBar(paymentId: widget.paymentId),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _getDeletedWidget(payment),
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
              const SizedBox(height: 48),
              payment.receiptImageUrl.isNullOrEmpty()
                  ? _getNoReceiptWiget(paymentProvider)
                  : _getReceiptWidget(payment)
            ],
          ),
        );
      },
    );
  }

  Widget _getDeletedWidget(Payment payment) {
    return payment.deleted
        ? DeletedAlertBox(
            title: 'Payment has been deleted!',
            deleteDate: payment.deleteDate,
            deleteReason: payment.deleteReason)
        : const SizedBox();
  }

  Widget _getNoReceiptWiget(PaymentProvider provider) {
    if (isProcessing) {
      return const Column(
        children: [
          SpinKitWaveSpinner(color: Color(0xFF008080), size: 96.0),
          SizedBox(height: 12),
          ParagraphTwoText(text: 'Uploading image ...')
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ParagraphOneText(text: "Upload receipt to this payment"),
          MyImagePicker(
              title: '',
              isProcessing: false,
              onImageSelected: (file) {
                _uploadImageAndUpdateReceiptImageUrl(provider, file);
              }),
        ],
      );
    }
  }

  Widget _getReceiptWidget(Payment payment) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ParagraphOneText(text: "Receipt"),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 48.0, right: 48.0),
          child: Container(
            decoration: BoxDecoration(
              // Specify the border for the container
              border: Border.all(
                color: Colors.black, // Color of the border
                width: 1.0, // Width of the border
              ),
              // Specify the border radius
              borderRadius: BorderRadius.circular(
                  2.0), // Adjust the radius to get the desired roundness
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              payment.receiptImageUrl,
              // width: 200,
              // height: 200,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                    child: SpinKitWaveSpinner(
                        color: Color(0xFF008080), size: 96.0));
              },
            ),
          ),
        ),
      ],
    );
  }
}
