import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class OrganizationSettingsDataModel extends BaseDataModel {
  final String organizationId;
  final String key;
  final String value;

  OrganizationSettingsDataModel({
    required super.id,
    required super.createdAt,
    required this.organizationId,
    required this.key,
    required this.value,
  });

  factory OrganizationSettingsDataModel.fromJson(Map<String, dynamic> data) {
    return OrganizationSettingsDataModel(
      id: data['id'],
      createdAt: data['created_at'].toString().toDate(),
      organizationId: data['organization_id'],
      key: data['key'],
      value: data['value'],
    );
  }
}
