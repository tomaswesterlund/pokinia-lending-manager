import 'package:pokinia_lending_manager/data/models/payment_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class PaymentEntity extends BaseEntity {
  final String clientId;
  final String loanId;
  final String? loanStatementId;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final DateTime payDate;
  final String? receiptImageUrl;
  final String? description;
  final DateTime? deleteDate;
  final String? deleteReason;

  bool get deleted => deleteDate != null;

  const PaymentEntity({
    required super.id,
    required super.createdAt,
    required this.clientId,
    required this.loanId,
    required this.loanStatementId,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.payDate,
    required this.receiptImageUrl,
    required this.description,
    required this.deleteDate,
    required this.deleteReason,
  });

  factory PaymentEntity.fromDataModel(PaymentDataModel dataModel) {
    return PaymentEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      clientId: dataModel.clientId,
      loanId: dataModel.loanId,
      loanStatementId: dataModel.loanStatementId,
      interestAmountPaid: dataModel.interestAmountPaid,
      principalAmountPaid: dataModel.principalAmountPaid,
      payDate: dataModel.payDate,
      receiptImageUrl: dataModel.receiptImageUrl,
      description: dataModel.description,
      deleteDate: dataModel.deleteDate,
      deleteReason: dataModel.deleteReason,
    );
  }
}
