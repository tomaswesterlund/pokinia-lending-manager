import 'package:pokinia_lending_manager/data/models/loans/open_ended_loan.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class OpenEndedLoanEntity extends BaseEntity {
  final DateTime startDate;
  final String paymentPeriod;
  final double initialPrincipalAmount;
  final double principalAmountPaid;
  final double interestAmountPaid;
  final double interestRate;

  double get remainingPrincipalAmount =>
      initialPrincipalAmount - principalAmountPaid;

  OpenEndedLoanEntity({
    required super.id,
    required super.createdAt,
    required this.startDate,
    required this.paymentPeriod,
    required this.initialPrincipalAmount,
    required this.principalAmountPaid,
    required this.interestAmountPaid,
    required this.interestRate,
  });

  factory OpenEndedLoanEntity.fromDataModel(OpenEndedLoanDataModel dataModel) {
    return OpenEndedLoanEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      startDate: dataModel.startDate,
      paymentPeriod: dataModel.paymentPeriod,
      initialPrincipalAmount: dataModel.initialPrincipalAmount,
      principalAmountPaid: dataModel.principalAmountPaid,
      interestAmountPaid: dataModel.interestAmountPaid,
      interestRate: dataModel.interestRate,
    );
  }
}
