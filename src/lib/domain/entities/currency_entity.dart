import 'package:pokinia_lending_manager/data/models/currency_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class CurrencyEntity extends BaseEntity {
  final String key;
  final String name;

  CurrencyEntity({
    required super.id,
    required super.createdAt,
    required this.key,
    required this.name,
  });

  factory CurrencyEntity.fromDataModel(CurrencyDataModel dataModel) {
    return CurrencyEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      key: dataModel.key,
      name: dataModel.name,
    );
  }
}
