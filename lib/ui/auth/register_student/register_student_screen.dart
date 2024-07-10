import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/ui/auth/register_student/widgets/register_student_content.dart';

class RegisterStudentScreen extends StatelessWidget {
  const RegisterStudentScreen({super.key});

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
            children: [RegisterStudentContent()],
          ),
        ),
      ),
    ));
  }
}
