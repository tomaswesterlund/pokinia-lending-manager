import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';

class LoanService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<LoanModel>> getLoansStream() {
    var stream = _db.collection('loans').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => LoanModel.fromFirestore(doc)).toList());
    return stream;
  }

  addLoan(LoanModel loan) {
    _db.collection('loans').add(loan.toJson());
  }

  Stream<LoanModel> getLoanByIdStream(String id) {
    var stream = _db
        .collection('loans')
        .doc(id)
        .snapshots()
        .map((doc) => LoanModel.fromFirestore(doc));
    return stream;
  }

  Stream<List<LoanModel>> getLoansByClientIdStream(String clientId) {
    var stream = _db
        .collection('loans')
        .where('clientId', isEqualTo: clientId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => LoanModel.fromFirestore(doc)).toList());
    return stream;
  }

  List<LoanModel> getLoansByClientId(String clientId) {
    List<LoanModel> loans = [];

    var snapshots = _db
        .collection('loans')
        .where('clientId', isEqualTo: clientId)
        .snapshots();

    snapshots.forEach((snapshot) {
      for (var doc in snapshot.docs) {
        var data = LoanModel.fromFirestore(doc);
        loans.add(data);
      }
    });
    return loans;
  }
}
