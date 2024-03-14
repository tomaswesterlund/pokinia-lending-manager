class UserSettings {
  final String id;
  final String userId;
  final String selectedOrganzationId;
  final bool showDeletedClients;
  final bool showDeletedLoans;
  final bool showDeletedLoanStatements;
  final bool showDeletedPayments;

  UserSettings.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['user_id'],
        selectedOrganzationId = data['selected_organization_id'],
        showDeletedClients = data['show_deleted_clients'] ?? false,
        showDeletedLoans = data['show_deleted_loans'] ?? false,
        showDeletedLoanStatements = data['show_deleted_loan_statements'] ?? false,
        showDeletedPayments = data['show_deleted_payments'] ?? false;
}
