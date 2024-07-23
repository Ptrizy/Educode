import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/controller/video_controller.dart';
import 'package:quiz/data/model/video_response.dart';
import 'package:quiz/ui/learning_video/widgets/video_bab_1.dart';

class LearningSelectVideo extends StatelessWidget {
  final VideoController videoController = Get.put(VideoController(Get.find()));

  LearningSelectVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Image.asset("assets/images/star.png"),
        ),
        SizedBox(height: 24.h),
        Text("Video", style: AppFontStyle.headline4),
        Text("Pembelajaran", style: AppFontStyle.headline4),
        Text("Mari bersemangat untuk belajar hari ini !",
            style: AppFontStyle.regularLargeText.copyWith(fontSize: 16)),
        SizedBox(height: 24.h),
        _listVideo(context),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _listVideo(BuildContext context) {
    return Obx(() {
      if (videoController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (videoController.error.value != null) {
        return Center(child: Text(videoController.error.value!));
      } else {
        return Column(
          children: videoController.videos.value.map((video) {
            return _buildVideoItem(context, video);
          }).toList(),
        );
      }
    });
  }

  Widget _buildVideoItem(BuildContext context, Video video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h, top: 15.h),
          margin: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    video.image,
                    width: 100.w,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(video.title, style: AppFontStyle.regularLargeText),
                        SizedBox(height: 8.h),
                        Text('Sumber video : ${video.video}',
                            style: AppFontStyle.regularLargeText),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              CustomButton(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10.w, right: 10.w)),
                    Text("Lihat", style: AppFontStyle.largeTextBold),
                    SizedBox(width: 210.w),
                    const Icon(Icons.arrow_forward, color: Colors.black),
                  ],
                ),
                onPressed: () {
                  Get.to(() => VideoBab1(videoURL: video.video));
                },
                height: 70.h,
                width: double.maxFinite.w,
                backgroundColor: Color(0XFFBDF565),
                borderRadius: 24,
              ),
            ],
          ),
        )
      ],
    );
  }
}
