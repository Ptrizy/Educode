import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/ui/intruction_student.dart/widgets/intruction_student_content.dart';

class IntructionStudentScreen extends StatelessWidget {
  const IntructionStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 12.h, bottom: 12.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [IntructionStudentContent()],
            ),
          ),
        ),
      ),
    );
  }
}
