import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/ui/home_student/widgets/home_student_content.dart';
import 'package:quiz/ui/home_student/widgets/home_student_menu_content.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h, bottom: 24.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeStudentContent(),
                SizedBox(
                  height: 24.h,
                ),
                const HomeStudentMenuContent(),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
