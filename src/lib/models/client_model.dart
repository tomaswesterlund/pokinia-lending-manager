import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  final String id;
  final String name;
  final String phoneNumber;

  ClientModel({required this.id, required this.name, required this.phoneNumber});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber']);
  }

  factory ClientModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      
    return ClientModel(
        id: doc.id,
        name: json['name'],
        phoneNumber: json['phoneNumber']);
  }

}
