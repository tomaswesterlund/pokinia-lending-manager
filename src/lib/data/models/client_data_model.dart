import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class ClientDataModel extends BaseDataModel {
  final String name;
  final String? phoneNumber;
  final String? address;
  final String? avatarImagePath;
  final String paymentStatus;
  final DateTime? deleteDate;
  final String? deleteReason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientDataModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  ClientDataModel(
      {required super.id,
      required super.createdAt,
      required this.name,
      required this.phoneNumber,
      this.address,
      this.avatarImagePath,
      required this.paymentStatus,
      this.deleteDate,
      this.deleteReason});

  @override
  factory ClientDataModel.fromJson(Map<String, dynamic> json) {
    return ClientDataModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      address: json['address'] as String,
      avatarImagePath: json['avatar_image_path'] as String,
      paymentStatus: json['payment_status'] as String,
      deleteDate: json['delete_date'] == null
          ? null
          : DateTime.parse(json['delete_date'] as String),
      deleteReason: json['delete_reason'] == null
          ? null
          : json['delete_reason'] as String,
    );
  }
}
