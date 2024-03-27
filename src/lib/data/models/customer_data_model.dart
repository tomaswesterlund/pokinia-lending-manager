import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class CustomerDataModel extends BaseDataModel {
  final String name;

  CustomerDataModel({
    required super.id,
    required super.createdAt,
    required this.name,
  });

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) {
    return CustomerDataModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
    );
  }
}
