import 'dart:io';
import 'package:get/get.dart';
import 'package:quiz/data/model/upload_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quiz/data/repository/upload/upload_repository.dart';

class UploadController extends GetxController {
  final UploadRepository _uploadRepository;
  final RxBool isLoading = false.obs;
  final Rx<UploadResponse?> uploadResponse = Rx<UploadResponse?>(null);
  final RxString fileName = ''.obs;

  UploadController(this._uploadRepository);

  Future<void> pickAndUploadPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        fileName.value = file.name;
        await uploadFile(File(file.path!));
      } else {
        // User canceled the picker
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memilih file: $e');
    }
  }

  Future<void> uploadFile(File file) async {
    isLoading.value = true;
    try {
      final result = await _uploadRepository.uploadFile(file);
      uploadResponse.value = result;
      Get.snackbar('Sukses', 'File berhasil diupload');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengupload file: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
