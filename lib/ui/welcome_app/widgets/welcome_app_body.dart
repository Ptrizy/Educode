import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/ui/auth/login_as/login_as_screen.dart';

class WelcomeAppBody extends StatelessWidget {
  const WelcomeAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: 80,
          child: Image.asset("assets/images/star.png"),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Educode",
                style: AppFontStyle.headline6.copyWith(fontSize: 40)),
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 100.h,
              width: 100.w,
              child: Image.asset(
                "assets/images/Vector.png",
                width: 150.w,
                height: 700.h,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: 400.h,
            width: 400.w,
            child: Image.asset("assets/images/splash_screen.png"),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 200.h,
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Media Pembelajaran masa kini",
                    style: AppFontStyle.headline4.copyWith(fontSize: 30)),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                    widget: const Text("Mulai",
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context)
                          .push(TransitionFade(child: const LoginAsScreen()));
                    },
                    height: 60.h,
                    width: double.maxFinite,
                    backgroundColor: const Color(0XFFBDF565),
                    borderRadius: 30)
              ],
            ),
          ),
        ])
      ],
    );
  }
}
