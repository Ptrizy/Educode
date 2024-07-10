import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/ui/add_materi_teacher/widgets/add_materi_content.dart';

class AddMateriTeacherScreen extends StatelessWidget {
  const AddMateriTeacherScreen({super.key});

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
              children: [AddMateriTeacherContent()],
            ),
          ),
        ),
      ),
    );
  }
}
