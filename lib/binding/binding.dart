import 'package:get/get.dart';
import 'package:quiz/controller/auth_controller.dart';
import 'package:quiz/controller/class_controller.dart';
import 'package:quiz/controller/course_controller.dart';
import 'package:quiz/controller/quiz_controller.dart';
import 'package:quiz/controller/upload_controller.dart';
import 'package:quiz/controller/video_controller.dart';
import 'package:quiz/data/repository/auth/auth_repository.dart';
import 'package:quiz/data/repository/auth/auth_repository_impl.dart';
import 'package:quiz/data/repository/class/class_repository.dart';
import 'package:quiz/data/repository/class/class_repository_impl.dart';
import 'package:quiz/data/repository/course/course_repository.dart';
import 'package:quiz/data/repository/course/course_repository_impl.dart';
import 'package:quiz/data/repository/quiz/quiz_repository.dart';
import 'package:quiz/data/repository/quiz/quiz_repository_impl.dart';
import 'package:quiz/data/repository/upload/upload_repository.dart';
import 'package:quiz/data/repository/upload/upload_repository_impl.dart';
import 'package:quiz/data/repository/video/video_repository.dart';
import 'package:quiz/data/repository/video/video_repository_impl.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<AuthController>(
        () => AuthController(Get.find<AuthRepository>()));

    Get.lazyPut<UploadRepository>(() => UploadRepositoryImpl());
    Get.lazyPut(() => UploadController(Get.find<UploadRepository>()));

    Get.lazyPut<ClassRepository>(() => ClassRepositoryImpl());
    Get.lazyPut(() => ClassController(Get.find<ClassRepository>()));

    Get.lazyPut<VideoRepository>(() => VideoRepositoryImpl());
    Get.lazyPut(() => VideoController(Get.find<VideoRepository>()));

    Get.lazyPut<CourseRepository>(() => CourseRepositoryImpl());
    Get.lazyPut(() => CourseController(Get.find<CourseRepository>()));

    Get.lazyPut<QuizRepository>(() => QuizRepositoryImpl());
    Get.lazyPut(() => QuizController(Get.find<QuizRepository>()));
  }
}
