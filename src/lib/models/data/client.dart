import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class Client {
  final String id;
  final String name;
  final String phoneNumber;
  final String? address;
  final String? avatarImagePath;
  final PaymentStatus paymentStatus;
  final DateTime? deleteDate;
  final String? deleteReason;

  bool get deleted => deleteDate != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Client && runtimeType == other.runtimeType && id == other.id;

  Client(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      this.address,
      this.avatarImagePath,
      this.paymentStatus = PaymentStatus.empty,
      this.deleteDate,
      this.deleteReason});

  factory Client.fromMap(Map<String, dynamic> json) {
    return Client(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        avatarImagePath: json['avatar_image_path'],
        paymentStatus: PaymentStatus.fromName(json['payment_status']),
        deleteDate: json['delete_date'] != null
            ? DateTime.parse(json['delete_date'])
            : null,
        deleteReason: json['delete_reason']);
  }
}
