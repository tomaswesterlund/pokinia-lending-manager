import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class CurrencyDataModel extends BaseDataModel {
  final String key;
  final String name;
  final String type;

  CurrencyDataModel({
    required super.id,
    required super.createdAt,
    required this.key,
    required this.name,
    required this.type,
  });

  factory CurrencyDataModel.fromJson(Map<String, dynamic> data) {
    return CurrencyDataModel(
      id: data['id'],
      createdAt: data['created_at'].toString().toDate(),
      key: data['key'],
      name: data['name'],
      type: data['type'],
    );
  }
}
