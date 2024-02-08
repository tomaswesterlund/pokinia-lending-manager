import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'package:pokinia_lending_manager/models/repsonse_model.dart';

class ClientService extends ChangeNotifier {
  final String baseApiUrl;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ClientService({required this.baseApiUrl});

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

  Future<ResponseModel> createClient(
      {required String name, required phoneNumber, String? address}) async {
    final url = Uri.parse('$baseApiUrl/clients');

    var body = {'name': name, 'phoneNumber': phoneNumber, 'address': address};

    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      // Successful response, handle the result
      print('Function executed successfully. Response: ${response.body}');
    } else {
      // Handle the error
      print(
          'Error calling Firebase function. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return ResponseModel(statusCode: response.statusCode, body: response.body);
  }
}
