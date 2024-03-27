import 'dart:io';

import 'package:pokinia_lending_manager/core/models/response.dart';

mixin StorageRepository {
  Future<String> uploadFileAndReturnUrl(
      String bucketName, String fileName, File file);

  Future<Response> uploadFile(String bucketName, String fileName, File file);

  String getPublicUrl(String bucketName, String fileName);
}
