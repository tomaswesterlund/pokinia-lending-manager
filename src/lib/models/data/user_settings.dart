class UserSettings {
  final String id;
  final String userId;
  final String? selectedCustomerId;

  UserSettings.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['user_id'],
        selectedCustomerId = data['selected_customer_id'];
}