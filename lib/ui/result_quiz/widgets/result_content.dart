import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/widgets/custom_button.dart';

class ResultContent extends StatelessWidget {
  const ResultContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Skor Jawaban kamu",
          style: AppFontStyle.headline4,
        ),
        SizedBox(
          height: 10.h,
        ),
        Image.asset("assets/images/champion.png"),
        SizedBox(
          height: 10.h,
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 30.w, right: 30.w, top: 40.h, bottom: 40.h),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Text(
                    "Selamat, Nilai kamu sangat bagus ayo tingkatkan Lagi",
                    style: AppFontStyle.largeTextBold.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("80",
                      style: AppFontStyle.headline4
                          .copyWith(fontSize: 90, color: Colors.lightGreen)),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 3,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Benar',
                            style: AppFontStyle.largeTextBold
                                .copyWith(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: 100.w, // Menambahkan ukuran lebar
                            height: 70.h,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0XFF00CBB1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '14',
                                style: AppFontStyle.largeTextBold.copyWith(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        children: [
                          Text(
                            'Salah',
                            style: AppFontStyle.largeTextBold
                                .copyWith(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: 100.w, // Menambahkan ukuran lebar
                            height: 70.h,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                '6',
                                style: AppFontStyle.largeTextBold.copyWith(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                    widget: Text(
                      "Home",
                      style: AppFontStyle.mediumLargeText,
                    ),
                    onPressed: () {},
                    height: 70.h,
                    width: 200.w,
                    backgroundColor: const Color(0XFF00CBB1),
                    borderRadius: 35),
                SizedBox(
                  width: 10.w,
                ),
                CustomButton(
                    widget: Text(
                      "Ulangi",
                      style: AppFontStyle.mediumLargeText,
                    ),
                    onPressed: () {},
                    height: 70.h,
                    width: 200.w,
                    backgroundColor: Colors.green,
                    borderRadius: 35)
              ],
            )
          ],
        )
      ],
    );
  }
}
