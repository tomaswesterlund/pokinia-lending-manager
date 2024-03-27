import 'package:pokinia_lending_manager/core/enums/loan_types.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/data/models/loans/loan_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class LoanEntity extends BaseEntity {
  final String clientId;
  final PaymentStatus paymentStatus;
  final LoanTypes type;
  final DateTime? deleteDate;
  final String? deleteReason;

  double get initialPrincipalAmount => -1;
  double get initialInterestRate => -1;
  double get remainingPrincipalAmount => -1;
  double get interestAmountPaid => -1;
  double get principalAmountPaid => -1;
  bool get deleted => paymentStatus == PaymentStatus.deleted;

  LoanEntity({
    required super.id,
    required super.createdAt,
    required this.clientId,
    required this.paymentStatus,
    required this.type,
    this.deleteDate,
    this.deleteReason,
  });

  factory LoanEntity.fromDataModel(LoanDataModel dataModel) {
    return LoanEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      clientId: dataModel.clientId,
      paymentStatus: PaymentStatus.fromName(dataModel.paymentStatus),
      type: LoanTypes.fromName(dataModel.type),
      deleteDate: dataModel.deleteDate,
      deleteReason: dataModel.deleteReason,
    );
  }
}
