abstract class BaseDataModel {
  final String id;
  final DateTime createdAt;

  BaseDataModel({required this.id, required this.createdAt});

  factory BaseDataModel.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}
