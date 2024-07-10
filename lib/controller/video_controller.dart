import 'package:get/get.dart';
import 'package:quiz/data/model/video_response.dart';
import 'package:quiz/data/repository/video/video_repository.dart';

class VideoController extends GetxController {
  final VideoRepository _videoRepository;

  VideoController(this._videoRepository);

  final isLoading = false.obs;
  final error = Rx<String?>(null);
  final videos = Rx<List<Video>>([]);

  @override
  void onInit() {
    super.onInit();
    getVideosByClassId();
  }

  Future<void> getVideosByClassId() async {
    isLoading.value = true;
    error.value = null;
    try {
      final response = await _videoRepository.getVideoByClassId();
      videos.value = response.data;
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load videos: ${e.toString()}');
    }
  }
}
