import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/entities/payment_entity.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/domain/services/receipt_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class PaymentPageViewModel extends BaseViewModel {
  final PaymentService _paymentService;
  final ReceiptService _receiptService;

  PaymentPageViewModel(this._paymentService, this._receiptService) {
    _paymentService.addListener(notifyListeners);
  }

  Either<CustomError, PaymentEntity> getPaymentById(String paymentId) {
    try {
      var payment = _paymentService.getById(paymentId);
      return Right(payment);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  Future<Either<CustomError, Success>> uploadReceiptImage(
      String paymentId, File file) async {
    try {
      super.state = States.processing;

      var url = await _receiptService.uploadReceiptAndGetPublicUrl(file);
      _paymentService.updateReceiptImageUrl(paymentId, url);

      super.state = States.ready;
      return Right(Success());
    } catch (e) {
      super.state = States.error;
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
