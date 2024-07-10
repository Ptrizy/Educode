import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/ui/learning_video/widgets/learning_select_video.dart';

class LearningVideoScreen extends StatelessWidget {
  const LearningVideoScreen({super.key});

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
            children: [LearningSelectVideo()],
          ),
        ),
      ),
    ));
  }
}
