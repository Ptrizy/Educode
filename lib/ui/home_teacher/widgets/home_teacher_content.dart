import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz/controller/auth_controller.dart';
import 'package:quiz/ui/add_materi_teacher/add_materi_teacher_screen.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/ui/auth/login_as/login_as_screen.dart';
import 'package:quiz/ui/student_quiz_score/select_student_quiz_score_screen.dart';

class HomeTeacherContent extends StatefulWidget {
  const HomeTeacherContent({super.key});

  @override
  State<HomeTeacherContent> createState() => _HomeTeacherContentState();
}

class _HomeTeacherContentState extends State<HomeTeacherContent> {
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
    } else if (status.isDenied) {
      print('Permission denied');
    }
  }

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.asset("assets/images/star.png"),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          "Halo, Guru",
          style: AppFontStyle.headline4,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          "Selamat Pagi!",
          style: AppFontStyle.regularCaption.copyWith(fontSize: 16),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Menu",
          style: AppFontStyle.headline5,
        ),
        SizedBox(
          height: 24.h,
        ),
        _listMateriTeacher(context),
        SizedBox(
          height: 24.h,
        ),
        _resultQuizStudent(context),
        SizedBox(
          height: 24.h,
        ),
        CustomButton(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left: 12.w, right: 12.w)),
                Text(
                  "Logout",
                  style: AppFontStyle.largeTextBold,
                ),
                SizedBox(
                  width: 18.w,
                ),
                const Icon(
                  Icons.logout,
                  color: Colors.black,
                )
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _authController.signOut().then((_) {
                if (!_authController.isLoading.value) {
                  Navigator.pushReplacement(
                    context,
                    TransitionFade(
                      child: const LoginAsScreen(),
                    ),
                  );
                }
              });
            },
            height: 70.h,
            width: double.maxFinite,
            backgroundColor: Colors.red,
            borderRadius: 35)
      ],
    );
  }

  Column _listMateriTeacher(BuildContext context) {
    return Column(
        children: List.generate(1, (index) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                TransitionFade(child: const AddMateriTeacherScreen()),
              );
            },
            child: Container(
                width: 370.w,
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                decoration: BoxDecoration(
                    color: const Color(0XFFF9F5EC),
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(5, 5),
                      )
                    ]),
                child: Row(
                  children: [
                    Image.asset("assets/images/Rectangle.png"),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Materi",
                            style: AppFontStyle.regularLargeText,
                          ),
                          Text(
                            "Upload materi untuk pembelajaran",
                            style: AppFontStyle.regularLargeText,
                          )
                        ],
                      ),
                    ),
                  ],
                )))
      ]);
    }));
  }

  Column _resultQuizStudent(BuildContext context) {
    return Column(
        children: List.generate(1, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  TransitionFade(child: const SelectStudentQuizScoreScreen()),
                );
              },
              child: Container(
                  width: 370.w,
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                  decoration: BoxDecoration(
                      color: const Color(0XFFFDEAE4),
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(5, 5),
                        )
                      ]),
                  child: Row(
                    children: [
                      Image.asset("assets/images/Rectangle.png"),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nilai kuis siswa",
                              style: AppFontStyle.regularLargeText,
                            ),
                            Text(
                              "Daftar nilai kuis para siswa",
                              style: AppFontStyle.regularLargeText,
                            )
                          ],
                        ),
                      )
                    ],
                  )))
        ],
      );
    }));
  }
}
