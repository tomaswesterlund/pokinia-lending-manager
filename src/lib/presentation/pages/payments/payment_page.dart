import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pokinia_lending_manager/components/universal/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/domain/entities/payment_entity.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/images/image_picker.dart';
import 'package:pokinia_lending_manager/view_models/pages/payments/payment_app_bar.dart';
import 'package:pokinia_lending_manager/view_models/pages/payments/payment_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/shared/unexpected_error.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final String paymentId;
  const PaymentPage({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentPageViewModel>(
      builder: (context, vm, _) {
        return vm.getPaymentById(paymentId).fold(
              (error) => const UnexpectedError(),
              (payment) => Scaffold(
                appBar: PaymentAppBar(paymentId: paymentId),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _getDeletedWidget(payment),
                    16.0.heightBox,
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
                    48.0.heightBox,
                    payment.receiptImageUrl.isNullOrEmpty()
                        ? _getNoReceiptUploadedWiget(vm)
                        : _getReceiptWidget(payment)
                  ],
                ),
              ),
            );
      },
    );
  }

  Widget _getDeletedWidget(PaymentEntity payment) {
    return payment.deleted
        ? DeletedAlertBox(
            title: 'Payment has been deleted!',
            deleteDate: payment.deleteDate,
            deleteReason: payment.deleteReason)
        : const SizedBox();
  }

  Widget _getUploadingImageWidget() {
    return const Column(
      children: [
        SpinKitWaveSpinner(color: Color(0xFF008080), size: 96.0),
        SizedBox(height: 12),
        ParagraphTwoText(text: 'Uploading image ...')
      ],
    );
  }

  Widget _getNoReceiptUploadedWiget(PaymentPageViewModel vm) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ParagraphOneText(text: "Upload receipt to this payment"),
        MyImagePicker(
          title: '',
          isProcessing: false,
          onImageSelected: (file) {
            vm.uploadReceiptImage(paymentId, file).fold(
                  (error) => ToastService().showErrorToast(
                      'An unexpected error occurred while uploading the receipt image ...'),
                  (_) => null,
                );
          },
        ),
      ],
    );
  }

  Widget _getReceiptWidget(PaymentEntity payment) {
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
              payment.receiptImageUrl!,
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
