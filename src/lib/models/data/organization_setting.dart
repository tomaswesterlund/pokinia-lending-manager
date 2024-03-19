import 'package:pokinia_lending_manager/util/string_extensions.dart';

class OrganizationSetting {
  final String id;
  final DateTime createdAt;
  final String organizationId;
  final String key;
  final String value;
  

  OrganizationSetting({
    required this.id,
    required this.createdAt,
    required this.organizationId,
    required this.key,
    required this.value,
  });


  OrganizationSetting.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        createdAt = data['created_at'].toString().toDate(),
        organizationId = data['organization_id'],
        key = data['key'],
        value = data['value'];
}