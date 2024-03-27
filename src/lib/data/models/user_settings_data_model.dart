import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class UserSettingsDataModel extends BaseDataModel {
  final String userId;
  final String selectedOrganzationId;
  final bool showDeletedClients;
  final bool showDeletedLoans;
  final bool showDeletedLoanStatements;
  final bool showDeletedPayments;

  UserSettingsDataModel({
    required super.id,
    required super.createdAt,
    required this.userId,
    required this.selectedOrganzationId,
    required this.showDeletedClients,
    required this.showDeletedLoans,
    required this.showDeletedLoanStatements,
    required this.showDeletedPayments,
  });

  factory UserSettingsDataModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsDataModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'],
      selectedOrganzationId: json['selected_organization_id'],
      showDeletedClients: json['show_deleted_clients'],
      showDeletedLoans: json['show_deleted_loans'],
      showDeletedLoanStatements: json['show_deleted_loan_statements'],
      showDeletedPayments: json['show_deleted_payments'],
    );
  }
}
