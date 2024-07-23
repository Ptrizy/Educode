import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/data/local/shared_preference/quiz_preference.dart';
import 'package:quiz/controller/quiz_controller.dart';
import 'package:quiz/data/model/quiz_response.dart';
import 'package:quiz/ui/quiz/quiz_screen.dart';
import 'package:quiz/ui/quiz/widgets/quiz_content.dart';

class ResultContent extends StatefulWidget {
  ResultContent({super.key});

  @override
  State<ResultContent> createState() => _ResultContentState();
}

class _ResultContentState extends State<ResultContent> {
  final QuizController quizController = Get.find<QuizController>();
  int? quizId;

  void _getQuizId() async {
    quizId = await QuizPreference.getQuizId();
  }

  @override
  void initState() {
    super.initState();
    _getQuizId();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (quizController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (quizController.error.value != null) {
        return Center(child: Text('Error: ${quizController.error.value}'));
      } else {
        final AttemptResult? result = quizController.quizResults.value?.data;
        if (result == null) {
          return const Center(child: Text('No result available'));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Skor Jawaban kamu",
              style: AppFontStyle.headline4,
            ),
            SizedBox(height: 10.h),
            Image.asset("assets/images/champion.png"),
            SizedBox(height: 10.h),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 30.w, right: 30.w, top: 40.h, bottom: 40.h),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Text(
                        getResultMessage(result),
                        style:
                            AppFontStyle.largeTextBold.copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "${result.result}",
                        style: AppFontStyle.headline4.copyWith(
                          fontSize: 90,
                          color: Colors.lightGreen,
                          shadows: [
                            const Shadow(
                              offset: Offset(6, 6),
                              blurRadius: 0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Divider(color: Colors.black, thickness: 3),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildResultCircle('Benar', result.rightAnswer,
                              const Color(0XFF00CBB1)),
                          SizedBox(width: 20.w),
                          _buildResultCircle(
                              'Salah', result.wrongAnswer, Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                      widget: Text("Quiz", style: AppFontStyle.mediumLargeText),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const QuizScreen()),
                        );
                      },
                      height: 70.h,
                      width: 200.w,
                      backgroundColor: const Color(0XFF00CBB1),
                      borderRadius: 35,
                    ),
                    SizedBox(width: 10.w),
                    CustomButton(
                      widget:
                          Text("Ulangi", style: AppFontStyle.mediumLargeText),
                      onPressed: () {
                        Get.to(QuizContent(quizId: quizId!));
                      },
                      height: 70.h,
                      width: 200.w,
                      backgroundColor: Colors.green,
                      borderRadius: 35,
                    )
                  ],
                )
              ],
            )
          ],
        );
      }
    });
  }

  Widget _buildResultCircle(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: AppFontStyle.largeTextBold
              .copyWith(color: Colors.black, fontSize: 20),
        ),
        SizedBox(height: 10.h),
        Container(
          width: 100.w,
          height: 70.h,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                blurRadius: 0,
                color: color,
              )
            ],
          ),
          child: Center(
            child: Text(
              '$value',
              style: AppFontStyle.largeTextBold
                  .copyWith(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}

String getResultMessage(dynamic result) {
  if (result?.result == null) {
    return "Hasil tidak tersedia";
  }

  int score;
  try {
    score = int.parse(result.result.toString());
  } catch (e) {
    return "Format hasil tidak valid";
  }

  if (score >= 0 && score <= 50) {
    return "Jangan berkecil hati, tetap semangat!";
  } else if (score >= 51 && score <= 64) {
    return "Kamu telah berusaha dengan baik, tingkatkan lagi belajarmu!";
  } else if (score >= 65 && score <= 74) {
    return "Usaha yang bagus, ayo sedikit lagi!";
  } else if (score >= 75 && score <= 100) {
    return "Good Job!";
  } else {
    return "Skor di luar rentang yang valid";
  }
}
