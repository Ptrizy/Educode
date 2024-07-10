import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/common/widgets/custom_field_form.dart';
import 'package:quiz/controller/course_controller.dart';
import 'package:quiz/controller/upload_controller.dart';
import 'package:quiz/data/local/shared_preference/course_preference.dart';
import 'package:quiz/ui/home_teacher/home_teacher_screen.dart';

class AddMateriTeacherContent extends StatefulWidget {
  const AddMateriTeacherContent({super.key});

  @override
  State<AddMateriTeacherContent> createState() =>
      _AddMateriTeacherContentState();
}

class _AddMateriTeacherContentState extends State<AddMateriTeacherContent> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  final UploadController _uploadController = Get.find<UploadController>();
  final CourseController _courseController = Get.find<CourseController>();

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            CoursePreference.deleteCourseUrl();
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
        SizedBox(
          height: 30.h,
        ),
        Text(
          "Materi",
          style: AppFontStyle.headline4,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Silahkan Upload materi untuk para siswa",
          style: AppFontStyle.regularLargeText,
        ),
        SizedBox(
          height: 30.h,
        ),
        _addMateri(context),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }

  Column _addMateri(BuildContext context) {
    return Column(
      children: List.generate(
        1,
        (index) {
          return Container(
            padding: EdgeInsets.only(
                left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 1, offset: Offset(5, 5))
                ],
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(35)),
            child: Column(
              children: [
                _uploadMateriFile(context),
                SizedBox(
                  height: 10.h,
                ),
                _buttonAddMateri(
                    context, _judulController, _deskripsiController)
              ],
            ),
          );
        },
      ),
    );
  }

  Column _uploadMateriFile(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _uploadController.pickAndUploadPDF(),
          child: Container(
            height: 300.h,
            width: double.infinity,
            padding: EdgeInsets.only(
                left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(35)),
            child: Center(
              child: Obx(() {
                if (_uploadController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (_uploadController.uploadResponse.value != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.picture_as_pdf),
                      SizedBox(height: 10.w),
                      Text(_uploadController.uploadResponse.value!.data ??
                          'PDF terupload'),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file),
                      SizedBox(height: 10.w),
                      const Text("Upload PDF"),
                    ],
                  );
                }
              }),
            ),
          ),
        )
      ],
    );
  }

  Column _buttonAddMateri(
    BuildContext context,
    TextEditingController title,
    TextEditingController description,
  ) {
    return Column(children: [
      CustomFieldForm(
          controller: _judulController,
          hintText: "Judul",
          maxLines: 1,
          obscureText: false,
          isEnabled: true,
          alphabetOnly: false,
          numberOnly: false),
      SizedBox(height: 10.h),
      CustomFieldForm(
          controller: _deskripsiController,
          hintText: "Deskripsi",
          maxLines: 1,
          obscureText: false,
          isEnabled: true,
          alphabetOnly: false,
          numberOnly: false),
      SizedBox(height: 10.h),
      CustomButton(
          widget: Text(
            "Simpan",
            style: AppFontStyle.mediumLargeText,
          ),
          onPressed: () async {
            try {
              await _courseController.createCourse(
                title.text,
                description.text,
              );
              Get.snackbar('Sukses', 'Materi PDF berhasil disimpan');
              Future.delayed(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeTeacherScreen()),
                ),
              );
            } catch (e) {
              Get.snackbar('Error', 'Harap upload file PDF terlebih dahulu');
            }
          },
          height: 75.w,
          width: 150.w,
          backgroundColor: const Color(0XFFBDF565),
          borderRadius: 25)
    ]);
  }
}
