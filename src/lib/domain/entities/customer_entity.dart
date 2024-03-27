import 'package:pokinia_lending_manager/data/models/customer_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class CustomerEntity extends BaseEntity {
  final String name;

  CustomerEntity({
    required super.id,
    required super.createdAt,
    required this.name,
  });

  factory CustomerEntity.fromDataModel(CustomerDataModel dataModel) {
    return CustomerEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      name: dataModel.name,
    );
  }
}