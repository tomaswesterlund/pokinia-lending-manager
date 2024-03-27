import 'package:pokinia_lending_manager/data/models/organization_settings_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class OrganizationSettingsEntity extends BaseEntity {
  final String organizationId;
  final String key;
  final String value;

  OrganizationSettingsEntity({
    required super.id,
    required super.createdAt,
    required this.organizationId,
    required this.key,
    required this.value,
  });

  factory OrganizationSettingsEntity.fromDataModel(
      OrganizationSettingsDataModel dataModel) {
    return OrganizationSettingsEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      organizationId: dataModel.organizationId,
      key: dataModel.key,
      value: dataModel.value,
    );
  }
}
