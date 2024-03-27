import 'package:pokinia_lending_manager/data/models/organization_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class OrganizationEntity extends BaseEntity {
  final String name;

  OrganizationEntity({
    required super.id,
    required super.createdAt,
    required this.name,
  });

  factory OrganizationEntity.fromDataModel(OrganizationDataModel dataModel) {
    return OrganizationEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      name: dataModel.name,
    );
  }
}
