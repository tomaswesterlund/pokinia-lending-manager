import 'dart:io';

import 'package:pokinia_lending_manager/models/data/payment.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ReceiptService {
  final LogService _logger = LogService('ReceiptService');
  final supabase = Supabase.instance.client;

  Future<String> uploadReceipt(File file) async {
    try {
      var fileName = '${const Uuid().v4()}.png';

      final response = await supabase.storage
          .from('receipts') // Replace with your storage bucket name
          .upload(fileName, file);

      var url = supabase.storage.from('receipts').getPublicUrl(fileName);

      return url;
    } catch (error) {
      _logger.e('uploadReceipt', 'Error uploading receipt: $error');
      rethrow;
    }
  }

  String getReceiptUrl(Payment payment) {
    var fileName = payment.receiptImageUrl.replaceAll('receipts/', '');
    var url = supabase.storage.from('receipts').getPublicUrl(fileName);
    return url;
  }
}
