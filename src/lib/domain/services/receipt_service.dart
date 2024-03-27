import 'dart:io';

import 'package:pokinia_lending_manager/domain/repositories/storage_repository.dart';
import 'package:uuid/uuid.dart';

class ReceiptService {
  final StorageRepository _storageRepository;

  ReceiptService(this._storageRepository);

  Future<String> uploadReceiptAndGetPublicUrl(File file) async {
    try {
      var fileName = '${const Uuid().v4()}.png';
      var url = await _storageRepository.uploadFileAndReturnUrl(
          'receipts', fileName, file);

      return url;
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> uploadReceiptAndGetPublicUrlOrNull(File? file) async {
    try {
      if (file == null) {
        return null;
      } else {
        return await uploadReceiptAndGetPublicUrl(file);
      }
    } catch (error) {
      return null;
    }
  }
}
