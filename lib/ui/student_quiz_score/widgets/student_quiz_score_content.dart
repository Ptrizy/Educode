import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:quiz/controller/quiz_controller.dart';

class StudentQuizScoreContent extends StatefulWidget {
  const StudentQuizScoreContent({super.key, required this.quizId});

  final int quizId;

  @override
  State<StudentQuizScoreContent> createState() =>
      _StudentQuizScoreContentState();
}

class _StudentQuizScoreContentState extends State<StudentQuizScoreContent> {
  final QuizController _quizController = Get.find<QuizController>();

  int progress = 0;
  int? downloadId;
  String? status;
  late StreamSubscription progressStream;

  @override
  void initState() {
    super.initState();
    _initializeDownloader();
    _requestPermission();
  }

  void _initializeDownloader() async {
    try {
      await FlDownloader.initialize();
      progressStream = FlDownloader.progressStream.listen(
        (event) {
          print(
              "Download event: ${event.status}, Progress: ${event.progress}, ID: ${event.downloadId}");
          setState(() {
            progress = event.progress;
            downloadId = event.downloadId;
            status = event.status.name;
          });

          if (event.status == DownloadStatus.successful) {
            print("Download successful. File path: ${event.filePath}");
            FlDownloader.openFile(filePath: event.filePath);
          }
        },
        onError: (error) {
          print("Error in download stream: $error");
          Get.snackbar('Error', 'Terjadi kesalahan saat mengunduh: $error');
        },
      );
    } catch (e) {
      print("Error initializing downloader: $e");
      Get.snackbar('Error', 'Gagal menginisialisasi pengunduh: $e');
    }
  }

  @override
  void dispose() {
    progressStream.cancel();
    super.dispose();
  }

  Future<void> _requestPermission() async {
    final permission = await FlDownloader.requestPermission();
    if (permission == StoragePermissionStatus.granted) {
      _quizController.getQuizResult(widget.quizId);
    } else {
      Get.snackbar('Perizinan Penyimpanan Ditolak',
          'Izinkan izin terlebih dahulu untuk melihat skor. Status: $permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackButton(),
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

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
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
              errorWidget: (error) =>
                  Center(child: Text('Error pdf : ${error.toString()}')),
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
      onPressed: () async {
        if (_quizController.quizResult.value?.data != null) {
          final permission = await FlDownloader.requestPermission();
          if (permission == StoragePermissionStatus.granted) {
            final id = await FlDownloader.download(
              _quizController.quizResult.value!.data!,
              fileName: 'quiz_result.pdf',
            );
            if (id != null) {
              setState(() {
                downloadId = id;
              });
              print("Download started with ID: $id");
            } else {
              Get.snackbar('Error', 'Gagal memulai unduhan.');
            }
          } else {
            Get.snackbar('Perizinan Ditolak',
                'Izin penyimpanan diperlukan untuk mengunduh file.');
          }
        } else {
          Get.snackbar('Error', 'Tidak ada file untuk diunduh.');
        }
      },
      height: 75.w,
      width: double.maxFinite,
      backgroundColor: const Color(0XFFBDF565),
      borderRadius: 25,
    );
  }
}
