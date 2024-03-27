import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class LoanDataModel extends BaseDataModel {
  final String clientId;
  final String paymentStatus;
  final String type;
  final DateTime? deleteDate;
  final String? deleteReason;

  LoanDataModel({
    required super.id,
    required super.createdAt,
    required this.clientId,
    required this.paymentStatus,
    required this.type,
    this.deleteDate,
    this.deleteReason,
  });

  @override
  factory LoanDataModel.fromJson(Map<String, dynamic> json) {
    return LoanDataModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      clientId: json['client_id'] as String,
      paymentStatus: json['payment_status'] as String,
      type: json['type'] as String,
      deleteDate: json['delete_date'] == null
          ? null
          : DateTime.parse(json['delete_date'] as String),
      deleteReason: json['delete_reason'] == null
          ? null
          : json['delete_reason'] as String,
    );
  }
}
