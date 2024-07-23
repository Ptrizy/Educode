import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/controller/quiz_controller.dart';
import 'package:quiz/ui/student_quiz_score/student_quiz_score_screen.dart';

class SelectStudentQuizScoreContent extends StatefulWidget {
  const SelectStudentQuizScoreContent({super.key});

  @override
  State<SelectStudentQuizScoreContent> createState() =>
      _SelectStudentQuizScoreContentState();
}

class _SelectStudentQuizScoreContentState
    extends State<SelectStudentQuizScoreContent> {
  final QuizController quizController = Get.find<QuizController>();

  @override
  void initState() {
    super.initState();
    quizController.getQuizByClassID();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (quizController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (quizController.error.value != null) {
        return Center(child: Text('Error: ${quizController.error.value}'));
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _backButton(context),
            SizedBox(height: 24.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nilai Kuis Siswa", style: AppFontStyle.headline4),
                SizedBox(height: 8.h),
                Text(
                  'Daftar nilai kuis yang dikerjakan siswa',
                  style: AppFontStyle.regularLargeText,
                )
              ],
            ),
            _listQuiz(context),
          ],
        );
      }
    });
  }

  Widget _backButton(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Widget _listQuiz(BuildContext context) {
    return Column(
      children: quizController.quizzes.map((quiz) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StudentQuizScoreScreen(
                      quizId: quiz.id,
                    ),
                  ),
                );
              },
              child: Container(
                width: 370.w,
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
                margin: EdgeInsets.symmetric(vertical: 18.h),
                decoration: BoxDecoration(
                  color: const Color(0XFFF9F5EC),
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0XFFFFC700),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(5, 5),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Image.network(
                      quiz.image,
                      width: 70.w,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(quiz.name, style: AppFontStyle.regularLargeText),
                          Text(quiz.description,
                              style: AppFontStyle.regularLargeText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
