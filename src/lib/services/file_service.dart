import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FileService {
  Future<String> uploadAvatar(File file) async {
    final path = 'files/avatar/${UniqueKey().toString()}.png';

    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  Future<String> uploadPaymentReceipt(File file) async {
    final path = 'files/payment_receipts/${UniqueKey().toString()}.png';

    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }
}
