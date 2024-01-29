import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';

class PaymentService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<PaymentModel> getPaymentByIdStream(String id) {
    var stream = _db
        .collection('payments')
        .doc(id)
        .snapshots()
        .map((doc) => PaymentModel.fromFirestore(doc));
    return stream;
  }

  Stream<List<PaymentModel>> getPaymentsByLoanIdStream(String loanId) {
    var stream = _db
        .collection('payments')
        .where('loanId', isEqualTo: loanId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PaymentModel.fromFirestore(doc))
            .toList());
    return stream;
  }
}
