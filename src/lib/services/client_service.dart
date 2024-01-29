import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';

class ClientService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  Stream<List<ClientModel>> getClientsStream() {
    var stream = _db.collection('clients').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ClientModel.fromFirestore(doc)).toList());
    
    return stream;
  }

Stream<ClientModel> getClientByIdStream(String id) {
    var stream = _db
        .collection('clients')
        .doc(id)
        .snapshots()
        .map((doc) => ClientModel.fromFirestore(doc));
    return stream;
  }

}
