// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:quiz/common/theme/app_font_style.dart';

// class HomeStudentContent extends StatelessWidget {
//   const HomeStudentContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           child: Image.asset("assets/images/star.png"),
//         ),
//         SizedBox(
//           height: 30.h,
//         ),
//         Text(
//           "Halo, Murid",
//           style: AppFontStyle.headline4,
//         ),
//         SizedBox(
//           height: 8.h,
//         ),
//         Text(
//           "Mari bersemangat untuk belajar hari ini !",
//           style: AppFontStyle.mediumLargeText,
//         ),
//         SizedBox(
//           height: 10.h,
//         ),
//         Container(
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.brown, width: 4),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Spacer(),
//               Image.asset("assets/images/capaian.png"),
//               Row(
//                   Expanded(child: Container()),
//                 children: [Image.asset("assets/images/Vector.png")],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/ui/capaian_pembelajaran/capaian_pembelajaran_screen.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';

class HomeStudentContent extends StatelessWidget {
  const HomeStudentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/images/star.png"),
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
                    "Capaian Pembelajaran",
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
                  CustomButton(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 15.w, right: 15.w)),
                          Text(
                            "Lihat",
                            style: AppFontStyle.largeTextBold,
                          ),
                          SizedBox(
                            width: 230.w,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            TransitionFade(
                                child: const CapaianPembelajaranScreen()));
                      },
                      height: 70.h,
                      width: double.maxFinite,
                      backgroundColor: const Color(0XFFBDF565),
                      borderRadius: 24)
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
