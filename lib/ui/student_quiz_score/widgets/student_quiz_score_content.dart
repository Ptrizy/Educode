import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:quiz/controller/quiz_controller.dart';

class StudentQuizScoreContent extends StatefulWidget {
  const StudentQuizScoreContent({super.key});

  @override
  State<StudentQuizScoreContent> createState() =>
      _StudentQuizScoreContentState();
}

class _StudentQuizScoreContentState extends State<StudentQuizScoreContent> {
  final QuizController _quizController = Get.find<QuizController>();

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.storage.status;

    if (!status.isGranted || status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.storage.request();
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
    }

    if (status.isGranted) {
      print('Permission granted');
      _quizController.getQuizResult();
    } else if (status.isDenied) {
      print('Permission denied');
      Get.snackbar('Perizinan Penyimpanan Anda Tolak',
          'Izinkan izin terlebih dahulu untuk melihat skor.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 59.w,
            width: 60.w,
            decoration: BoxDecoration(
              color: const Color(0XFFBDF565),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(3, 3),
                  blurRadius: 0,
                  spreadRadius: 1,
                )
              ],
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        SizedBox(height: 30.h),
        Text("Nilai Siswa", style: AppFontStyle.headline4),
        SizedBox(height: 20.h),
        Text("Daftar nilai kuis yang dikerjakan siswa",
            style: AppFontStyle.regularLargeText),
        SizedBox(height: 10.h),
        _scoreStudent(context),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _scoreStudent(BuildContext context) {
    return Obx(() {
      if (_quizController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (_quizController.error.value != null) {
        return Center(child: Text("Error: ${_quizController.error.value}"));
      } else {
        return Container(
          padding:
              EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, blurRadius: 1, offset: Offset(5, 5))
            ],
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Daftar skor kuis", style: AppFontStyle.headline6),
              SizedBox(height: 10.h),
              const Text(
                  "Berikut ini adalah daftar skor dari kuis - kuis yang dikerjakan oleh siswa"),
              SizedBox(height: 10.h),
              _pdfContent(context),
              SizedBox(height: 10.h),
              _buttonDownloadScoreStudent(context),
            ],
          ),
        );
      }
    });
  }

  Widget _pdfContent(BuildContext context) {
    return Container(
      height: 400.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(35),
      ),
      child: _quizController.quizResult.value?.data != null &&
              _quizController.quizResult.value!.data!.isNotEmpty
          ? PDF().cachedFromUrl(
              _quizController.quizResult.value!.data!,
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            )
          : const Center(child: Text("No PDF available")),
    );
  }

  Widget _buttonDownloadScoreStudent(BuildContext context) {
    return CustomButton(
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: 5.w, right: 5.w, top: 10.h, bottom: 10.h)),
          Text("Download",
              style: AppFontStyle.largeTextBold.copyWith(fontSize: 24)),
          SizedBox(width: 5.w),
          const Icon(Icons.sim_card_download_outlined,
              color: Colors.black, size: 27),
        ],
      ),
      onPressed: _quizController.downloadPDF,
      height: 75.w,
      width: double.maxFinite,
      backgroundColor: const Color(0XFFBDF565),
      borderRadius: 25,
    );
  }
}
