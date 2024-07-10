import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/controller/quiz_controller.dart';
import 'package:quiz/ui/quiz/widgets/quiz_content.dart';
import 'package:quiz/data/model/quiz_response.dart';

class QuizSelect extends StatefulWidget {
  const QuizSelect({super.key});

  @override
  State<QuizSelect> createState() => _QuizSelectState();
}

class _QuizSelectState extends State<QuizSelect> {
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
            SizedBox(height: 30.h),
            _informationQuiz(context),
            SizedBox(height: 24.h),
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

  Widget _informationQuiz(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kuis Bab 1", style: AppFontStyle.headline4),
        SizedBox(height: 8.h),
        Container(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 15.h),
          margin: EdgeInsets.all(5.w),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0XFF00CBB1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(5, 5),
              )
            ],
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: Color(0XFF3B82F6)),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  "Jawablah pertanyaan-pertanyaan berikut dengan benar, jika ada hal yang ingin ditanyakan silahkan hubungi pengajar!",
                  style: AppFontStyle.mediumTextBold.copyWith(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Image.asset("assets/images/quiz.png"),
      ],
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
                _showPopUp(quiz);
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
                    Image.asset("assets/images/Rectangle.png"),
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

  void _showPopUp(QuizInfo quiz) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Mulai ${quiz.name}",
            style: AppFontStyle.headline5,
          ),
          content: Text(
            "Nilai akan muncul ketika kamu menyelesaikan kuis!",
            style: AppFontStyle.regularLargeText,
          ),
          actions: [
            CustomButton(
              widget: Text(
                "Paham",
                style: AppFontStyle.mediumLargeText,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  TransitionFade(child: QuizContent(quizId: quiz.id)),
                );
              },
              height: 60.h,
              width: double.maxFinite,
              backgroundColor: const Color(0XFFBDF565),
              borderRadius: 35,
            )
          ],
        );
      },
    );
  }
}
