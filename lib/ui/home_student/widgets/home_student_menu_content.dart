import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/ui/intruction_student.dart/intruction_student_screen.dart';
import 'package:quiz/ui/learning_materi/learning_materi_screen.dart';
import 'package:quiz/ui/learning_video/learning_video_screen.dart';
import 'package:quiz/ui/quiz/quiz_screen.dart';

class HomeStudentMenuContent extends StatelessWidget {
  const HomeStudentMenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu",
          style: AppFontStyle.headline5,
        ),
        SizedBox(
          height: 24.h,
        ),
        _listMenuMateri(context),
        SizedBox(
          height: 24.h,
        ),
        _listVideoPembelajaran(context),
        SizedBox(
          height: 24.h,
        ),
        _listQuiz(context),
        SizedBox(
          height: 24.h,
        ),
        _listPetunjuk(context),
      ],
    );
  }

  Column _listMenuMateri(BuildContext context) {
    return Column(
        children: List.generate(1, (index) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                TransitionFade(child: const LearningMateriScreen()),
              );
            },
            child: Container(
                width: 370.w,
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0XFFFFC700),
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
                            "Video pembelajaran berisi materi tentang Informatika",
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

  Column _listVideoPembelajaran(BuildContext context) {
    return Column(
        children: List.generate(1, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  TransitionFade(child: const LearningVideoScreen()),
                );
              },
              child: Container(
                  width: 370.w,
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0XFFC7B9FF),
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
                              "Video Pembelajaran",
                              style: AppFontStyle.regularLargeText,
                            ),
                            Text(
                              "Video pembelajaran berisi materi tentang Informatika",
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

  Column _listQuiz(BuildContext context) {
    return Column(
        children: List.generate(1, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, TransitionFade(child: const QuizScreen()));
              },
              child: Container(
                  width: 370.w,
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0XFFFF8577),
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
                              "Kuis",
                              style: AppFontStyle.regularLargeText,
                            ),
                            Text(
                              "Video pembelajaran berisi materi tentang Informatika",
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

  Column _listPetunjuk(BuildContext context) {
    return Column(
        children: List.generate(1, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    TransitionFade(child: const IntructionStudentScreen()));
              },
              child: Container(
                  width: 370.w,
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0XFF00CBB1),
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
                              "Petunjuk",
                              style: AppFontStyle.regularLargeText,
                            ),
                            Text(
                              "Video pembelajaran berisi materi tentang Informatika",
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
