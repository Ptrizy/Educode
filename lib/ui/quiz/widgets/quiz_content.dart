import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/controller/quiz_controller.dart';
import 'package:quiz/ui/result_quiz/result_quiz.screen.dart';
import 'package:quiz/data/model/quiz_response.dart';

class QuizContent extends StatelessWidget {
  final int quizId;

  QuizContent({super.key, required this.quizId});

  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      quizController.getQuizById(quizId);
    });
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Obx(() {
            if (quizController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (quizController.error.value != null) {
              return Center(
                  child: Text('Error: ${quizController.error.value}'));
            } else if (quizController.currentQuiz.value == null) {
              return const Center(child: Text('No quiz data available'));
            } else {
              return QuizContents(
                  quizData: quizController.currentQuiz.value!.data);
            }
          }),
        ),
      ),
    );
  }
}

class QuizContents extends StatefulWidget {
  final QuizData quizData;

  const QuizContents({super.key, required this.quizData});

  @override
  _QuizContentsState createState() => _QuizContentsState();
}

class _QuizContentsState extends State<QuizContents> {
  String? selectedOption;
  String? selectedFullAnswer;
  int currentQuestionIndex = 0;
  final List<QuizAnswer> answers = [];

  @override
  void initState() {
    super.initState();
    updateIsOptionENull();
  }

  late bool isOptionENull;

  void updateIsOptionENull() {
    isOptionENull =
        widget.quizData.questions[currentQuestionIndex].optionE == null;
  }

  void _onOptionSelected(String option, String fullAnswer) {
    setState(() {
      selectedOption = option;
      selectedFullAnswer = fullAnswer;
    });
  }

  void _onNextPressed() {
    if (selectedOption == null) {
      Get.snackbar('Pilih Opsi!', 'Silakan pilih salah satu opsi');
      return;
    }

    final currentQuestion = widget.quizData.questions[currentQuestionIndex];
    answers.add(QuizAnswer(
        quizQuestionID: currentQuestion.id,
        answer: escapeString(selectedFullAnswer!)));

    if (currentQuestionIndex < widget.quizData.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
        updateIsOptionENull();
      });
    } else {
      Get.find<QuizController>().attemptQuiz(
        widget.quizData.id,
        answers,
      );
      Navigator.push(
        context,
        TransitionFade(child: const ResultQuizScreen()),
      );
    }
  }

  String escapeString(String str) {
    return str
        .replaceAll('"', '\\"')
        .replaceAll('\n', '\\n')
        .replaceAll('\r', '\\r')
        .replaceAll('\t', '\\t');
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.quizData.questions[currentQuestionIndex];
    bool isLastQuestion =
        currentQuestionIndex == widget.quizData.questions.length - 1;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.quizData.name,
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
                  style: AppFontStyle.largeTextBold.copyWith(fontSize: 16),
                ),
                SizedBox(height: 20.h),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    QuizOption(
                      option: "A",
                      text: currentQuestion.optionA,
                      isSelected: selectedOption == "A",
                      onOptionSelected: () =>
                          _onOptionSelected("A", currentQuestion.optionA),
                    ),
                    QuizOption(
                      option: "B",
                      text: currentQuestion.optionB,
                      isSelected: selectedOption == "B",
                      onOptionSelected: () =>
                          _onOptionSelected("B", currentQuestion.optionB),
                    ),
                    QuizOption(
                      option: "C",
                      text: currentQuestion.optionC,
                      isSelected: selectedOption == "C",
                      onOptionSelected: () =>
                          _onOptionSelected("C", currentQuestion.optionC),
                    ),
                    QuizOption(
                      option: "D",
                      text: currentQuestion.optionD,
                      isSelected: selectedOption == "D",
                      onOptionSelected: () =>
                          _onOptionSelected("D", currentQuestion.optionD),
                    ),
                    if (!isOptionENull)
                      QuizOption(
                        option: "E",
                        text: currentQuestion.optionE!,
                        isSelected: selectedOption == "E",
                        onOptionSelected: () =>
                            _onOptionSelected("E", currentQuestion.optionE!),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            widget: Text(
              isLastQuestion ? "Selesai" : "Selanjutnya",
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
}

class QuizOption extends StatelessWidget {
  final String option;
  final String text;
  final bool isSelected;
  final VoidCallback onOptionSelected;

  const QuizOption({
    Key? key,
    required this.option,
    required this.text,
    required this.isSelected,
    required this.onOptionSelected,
  }) : super(key: key);

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
          "$option. $text",
          style: AppFontStyle.mediumLargeText.copyWith(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
