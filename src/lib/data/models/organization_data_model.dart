import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class OrganizationDataModel extends BaseDataModel {
  final String name;

  OrganizationDataModel({
    required super.id,
    required super.createdAt,
    required this.name,
  });

  factory OrganizationDataModel.fromJson(Map<String, dynamic> json) {
    return OrganizationDataModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
    );
  }
}
