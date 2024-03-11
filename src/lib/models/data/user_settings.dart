class UserSettings {
  final String id;
  final String userId;
  final String selectedOrganzationId;

  UserSettings.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['user_id'],
        selectedOrganzationId = data['selected_organization_id'];
}