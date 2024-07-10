import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/controller/quiz_controller.dart';
import 'package:quiz/ui/result_quiz/result_quiz.screen.dart';
import 'package:quiz/data/model/quiz_response.dart';

class QuizContent extends StatefulWidget {
  final int quizId;

  const QuizContent({Key? key, required this.quizId}) : super(key: key);

  @override
  _QuizContentState createState() => _QuizContentState();
}

class _QuizContentState extends State<QuizContent> {
  final QuizController quizController = Get.find<QuizController>();
  final Rx<String?> selectedOption = Rx<String?>(null);
  int currentQuestionIndex = 0;
  final List<QuizAnswer> answers = [];

  @override
  void initState() {
    super.initState();
    quizController.getQuizById(widget.quizId);
  }

  void _onOptionSelected(String option) {
    selectedOption.value = option;
  }

  void _onNextPressed() {
    final currentQuestion =
        quizController.currentQuiz.value?.data.questions[currentQuestionIndex];
    answers.add(QuizAnswer(
        quizQuestionID: currentQuestion!.id, answer: selectedOption.value!));

    if (currentQuestionIndex <
        (quizController.currentQuiz.value?.data.questions.length ?? 0) - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption.value = null;
      });
    } else {
      quizController.attemptQuiz(
          QuizAttemptRequest(quizID: widget.quizId, answers: answers));
      Navigator.push(
        context,
        TransitionFade(child: const ResultQuizScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: GetBuilder<QuizController>(builder: (_) {
            print('isLoading: ${quizController.isLoading.value}');
            print('error: ${quizController.error.value}');
            print('currentQuiz: ${quizController.currentQuiz.value}');
            if (quizController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (quizController.error.value != null) {
              return Center(
                  child: Text('Error: ${quizController.error.value}'));
            } else if (quizController.currentQuiz.value == null) {
              return const Center(child: Text('No quiz data available'));
            } else {
              QuizData quizData = quizController.currentQuiz.value!.data;
              Question currentQuestion =
                  quizData.questions[currentQuestionIndex];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizData.name,
                      style: AppFontStyle.headline4,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentQuestionIndex + 1}. ${currentQuestion.question}",
                            style: AppFontStyle.largeTextBold
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 20.h),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              QuizOption(
                                option: "A. ${currentQuestion.optionA}",
                                isSelected: selectedOption == "A",
                                onOptionSelected: () => _onOptionSelected("A"),
                              ),
                              QuizOption(
                                option: "B. ${currentQuestion.optionB}",
                                isSelected: selectedOption == "B",
                                onOptionSelected: () => _onOptionSelected("B"),
                              ),
                              QuizOption(
                                option: "C. ${currentQuestion.optionC}",
                                isSelected: selectedOption == "C",
                                onOptionSelected: () => _onOptionSelected("C"),
                              ),
                              QuizOption(
                                option: "D. ${currentQuestion.optionD}",
                                isSelected: selectedOption == "D",
                                onOptionSelected: () => _onOptionSelected("D"),
                              ),
                              QuizOption(
                                option: "E. ${currentQuestion.optionE}",
                                isSelected: selectedOption == "E",
                                onOptionSelected: () => _onOptionSelected("E"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      widget: Text(
                        "Selanjutnya",
                        style: AppFontStyle.mediumLargeText,
                      ),
                      onPressed: _onNextPressed,
                      width: double.maxFinite,
                      height: 60.h,
                      backgroundColor: const Color(0XFFBDF565),
                      borderRadius: 25,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}

class QuizOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onOptionSelected;

  const QuizOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOptionSelected,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.symmetric(vertical: 7.h),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 4),
              blurRadius: 0,
              spreadRadius: 1,
            )
          ],
          color: isSelected ? const Color(0XFF9747FF) : Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          option,
          style: AppFontStyle.mediumLargeText,
        ),
      ),
    );
  }
}
