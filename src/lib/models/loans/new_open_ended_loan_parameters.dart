import 'package:pokinia_lending_manager/models/client.dart';

class NewOpenEndedLoanParameters {
  Client? client;
  String? paymentPeriod;
  DateTime? startDate;
  double? principalAmount;
  double? interestRate;
  int? generateLoanStatementsIntoTheFuture;
}