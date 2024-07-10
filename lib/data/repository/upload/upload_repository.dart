import 'dart:io';

import 'package:quiz/data/model/upload_response.dart';

abstract class UploadRepository {
  Future<UploadResponse> uploadFile(File file);
}
