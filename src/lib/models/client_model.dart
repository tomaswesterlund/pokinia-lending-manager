import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class ClientModel {
  final String id;
  final String name;
  final String phoneNumber;
  final PaymentStatus paymentStatus;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  ClientModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      this.paymentStatus = PaymentStatus.empty});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        paymentStatus: PaymentStatus.fromName(json['paymentStatus']));
  }

  factory ClientModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return ClientModel(
      id: doc.id,
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      paymentStatus: PaymentStatus.fromName(json['paymentStatus']),
    );
  }
  
  
}
