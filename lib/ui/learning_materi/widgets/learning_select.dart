import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/ui/learning_materi/widgets/learning_materi_content.dart';

class LearningMateriSelect extends StatelessWidget {
  const LearningMateriSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.asset("assets/images/star.png"),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          "Halo, Murid",
          style: AppFontStyle.headline4,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          "Mari bersemangat untuk belajar hari ini !",
          style: AppFontStyle.regularCaption.copyWith(fontSize: 16),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 15.h),
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/capaian.png"),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Materi",
                    style: AppFontStyle.headline5
                        .copyWith(color: const Color(0XFFFF8577)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Capaian pembelajaran dalam kuis ini  bisa dilihat pada file berikut ",
                    style: AppFontStyle.regularCaption.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        widget: Text("Download",
                            style: AppFontStyle.mediumLargeText),
                        onPressed: () {},
                        height: 70.h,
                        width: 180.w,
                        backgroundColor: Color(0XFFBDF565),
                        borderRadius: 35,
                      ),
                      CustomButton(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, right: 15.w)),
                            Text(
                              "Lihat",
                              style: AppFontStyle.mediumLargeText,
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              TransitionFade(child: LearningMateriContent()));
                        },
                        height: 70.h,
                        width: 180.w,
                        backgroundColor: const Color(0XFFBDF565),
                        borderRadius: 24,
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/images/Vector.png"),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
