import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/data/models/client_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class ClientEntity extends BaseEntity {
  final String name;
  final String? phoneNumber;
  final String? address;
  final String? avatarImagePath;
  final PaymentStatus paymentStatus;
  final DateTime? deleteDate;
  final String? deleteReason;

  bool get deleted => deleteDate != null;

  ClientEntity({
    required super.id,
    required super.createdAt,
    required this.name,
    required this.phoneNumber,
    this.address,
    this.avatarImagePath,
    required this.paymentStatus,
    this.deleteDate,
    this.deleteReason,
  });

  factory ClientEntity.fromDataModel(ClientDataModel dataModel) {
    return ClientEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      name: dataModel.name,
      phoneNumber: dataModel.phoneNumber,
      address: dataModel.address,
      avatarImagePath: dataModel.avatarImagePath,
      paymentStatus: PaymentStatus.fromName(dataModel.paymentStatus),
      deleteDate: dataModel.deleteDate,
      deleteReason: dataModel.deleteReason,
    );
  }
}
