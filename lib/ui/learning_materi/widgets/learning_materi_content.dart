import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:quiz/controller/course_controller.dart';

class LearningMateriContent extends StatefulWidget {
  const LearningMateriContent({super.key});

  @override
  _LearningMateriContentState createState() => _LearningMateriContentState();
}

class _LearningMateriContentState extends State<LearningMateriContent> {
  final CourseController courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    courseController.getCoursesByClassId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Materi",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0XFFBDF565),
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (courseController.error.value != null) {
          return Center(child: Text(courseController.error.value!));
        } else if (courseController.courses.value.isEmpty) {
          return const Center(child: Text("No courses available"));
        } else {
          return _buildPdfView(courseController.courses.value[0].course);
        }
      }),
    );
  }

  Widget _buildPdfView(String pdfUrl) {
    return PDF(
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
      onError: (error) {
        print(error.toString());
      },
      onPageError: (page, error) {
        print('$page: ${error.toString()}');
      },
      onPageChanged: (int? page, int? total) {
        print('page change: $page/$total');
      },
    ).cachedFromUrl(
      pdfUrl,
      placeholder: (progress) => Center(child: Text('$progress %')),
      errorWidget: (error) => Center(child: Text(error.toString())),
    );
  }
}
