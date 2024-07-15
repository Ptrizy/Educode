import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart'; // Pastikan untuk mengimpor TransitionFade
import 'package:quiz/ui/auth/login_student/login_student_screen.dart';
import 'package:quiz/ui/auth/login_teacher/login_teacher_screen.dart';

class LoginAsContent extends StatelessWidget {
  const LoginAsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Image.asset("assets/images/star.png"),
        ),
        SizedBox(
          height: 32.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Educode",
                style: AppFontStyle.headline6.copyWith(fontSize: 40)),
            SizedBox(
              width: 10.w, // Lebar antara gambar dan tulisan
            ),
            SizedBox(
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
          height: 32.h,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Masuk", style: AppFontStyle.headline6.copyWith(fontSize: 40)),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Sebagai",
            style: AppFontStyle.headline6.copyWith(fontSize: 40),
          ),
          SizedBox(
            height: 50.h,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    TransitionFade(
                        child:
                            const LoginTeacherScreen()), // Gantilah dengan halaman tujuan
                  );
                },
                child: Container(
                  height: 300.h,
                  width: 180.w,
                  padding: EdgeInsets.only(
                      left: 1.w, right: 1.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: 200.w,
                        child: Image.asset("assets/images/guru.png"),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Guru",
                        style: AppFontStyle.largeTextBold,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    TransitionFade(
                        child:
                            const LoginStudentScreen()), // Gantilah dengan halaman tujuan
                  );
                },
                child: Container(
                  height: 300.h,
                  width: 180.w,
                  padding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: 200.w,
                        child: Image.asset("assets/images/murid.png"),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Siswa",
                        style: AppFontStyle.largeTextBold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ],
    );
  }
}
