import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/ui/quiz/widgets/quiz_select.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: 24.w, right: 24.w, top: 12.h, bottom: 12.h),
        child: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [QuizSelect()],
          ),
        ),
      ),
    ));
  }
}
