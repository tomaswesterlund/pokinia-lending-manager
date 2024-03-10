class UserSettings {
  final String id;
  final String userId;
  final String? selectedCustomerId;
  final String selectedOrganzationId;

  UserSettings.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['user_id'],
        selectedCustomerId = data['selected_customer_id'],
        selectedOrganzationId = data['selected_organization_id'];
}