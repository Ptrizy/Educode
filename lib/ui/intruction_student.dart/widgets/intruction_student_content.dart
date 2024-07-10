// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:quiz/common/theme/app_font_style.dart';
// import 'package:quiz/common/widgets/custom_button.dart';

// class IntructionStudentContent extends StatelessWidget {
//   const IntructionStudentContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Container(
//           height: 59.w,
//           width: 60.w,
//           decoration: BoxDecoration(
//             color: Color(0XFFBDF565),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black,
//                 offset: Offset(3, 3),
//                 blurRadius: 0,
//                 spreadRadius: 1,
//               )
//             ],
//             border: Border.all(color: Colors.black, width: 2),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           child: Icon(Icons.arrow_back),
//         ),
//       ),
//       SizedBox(
//         height: 30.h,
//       ),
//       Text(
//         "Petunjuk",
//         style: AppFontStyle.headline4,
//       ),
//       SizedBox(
//         height: 10.h,
//       ),
//       Text(
//         "Apa yang bisa kami bantu?",
//         style: AppFontStyle.regularLargeText.copyWith(fontSize: 18),
//       ),
//       SizedBox(
//         height: 20.h,
//       ),
//       _listIntruction(context),
//       SizedBox(height: 20.h,),
//       _logoutButton(context),

//     ]);
//   }

//   Column _listIntruction(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding:
//               EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0XFFFFC700),
//                 spreadRadius: 1,
//                 blurRadius: 4,
//                 offset: Offset(5, 5),
//               )
//             ],
//             border: Border.all(color: Colors.black, width: 2),
//             borderRadius: BorderRadius.circular(32),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.chat_outlined,
//                 color: Colors.black,
//                 size: 30,
//               ),
//               SizedBox(width: 10.h),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Petunjuk Pengerjaan",
//                         style: AppFontStyle.headline6.copyWith(fontSize: 20)),
//                     SizedBox(height: 10.h),
//                     Text("1. Buat akun, Masukan nama, kelas, dan password",
//                         style: AppFontStyle.regularLargeText
//                             .copyWith(fontSize: 18)),
//                     SizedBox(height: 10.h),
//                     Text(
//                         "2. Login menggunakan Nama dan Password yang telah didaftarkan",
//                         style: AppFontStyle.regularLargeText
//                             .copyWith(fontSize: 18)),
//                     SizedBox(height: 10.h),
//                     Text("3. Pilih menu yang diinginkan",
//                         style: AppFontStyle.regularLargeText
//                             .copyWith(fontSize: 18)),
//                     SizedBox(height: 10.h),
//                     Text("4. Tunggu instruksi dari guru",
//                         style: AppFontStyle.regularLargeText
//                             .copyWith(fontSize: 18)),
//                     SizedBox(height: 10.h),
//                     Text(
//                         "5. Setelah selai mengerjakan lalu pilih petunjuk dan tap log out",
//                         style: AppFontStyle.regularLargeText
//                             .copyWith(fontSize: 18)),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Column _logoutButton (BuildContext context) {
//     return Column(
//       children: [ CustomButton(
//             widget: Text(
//               "Masuk",
//               style: AppFontStyle.mediumLargeText,
//             ),
//             onPressed: () {
//               _showPopUp();
//             },
//             height: 80.h,
//             width: double.maxFinite,
//             backgroundColor: Color(0XFFBDF565),
//             borderRadius: 10),
//         SizedBox(
//           height: 10.h,
//         ),

//       ],
//     );
//   }

//   void _showPopUp() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(title: Text("Berhasil Masuk"), actions: [
//           CustomButton(
//               widget: Text(
//                 "OKE",
//                 style: AppFontStyle.mediumLargeText,
//               ),
//               onPressed: () {

//               },
//               height: 70.h,
//               width: double.maxFinite,
//               backgroundColor: Color(0XFFBDF565),
//               borderRadius: 35)
//         ]);
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/controller/auth_controller.dart';
import 'package:quiz/ui/auth/login_as/login_as_screen.dart';

class IntructionStudentContent extends StatelessWidget {
  IntructionStudentContent({super.key});

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 59.w,
          width: 60.w,
          decoration: BoxDecoration(
            color: const Color(0XFFBDF565),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(3, 3),
                blurRadius: 0,
                spreadRadius: 1,
              )
            ],
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      SizedBox(
        height: 30.h,
      ),
      Text(
        "Petunjuk",
        style: AppFontStyle.headline4,
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        "Apa yang bisa kami bantu?",
        style: AppFontStyle.regularLargeText.copyWith(fontSize: 18),
      ),
      SizedBox(
        height: 20.h,
      ),
      _listIntruction(context),
      SizedBox(
        height: 20.h,
      ),
      _logoutButton(context),
    ]);
  }

  Column _listIntruction(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0XFFFFC700),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(5, 5),
              )
            ],
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.chat_outlined,
                color: Colors.black,
                size: 30,
              ),
              SizedBox(width: 10.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Petunjuk Pengerjaan",
                        style: AppFontStyle.headline6.copyWith(fontSize: 20)),
                    SizedBox(height: 10.h),
                    Text("1. Buat akun, Masukan nama, kelas, dan password",
                        style: AppFontStyle.regularLargeText
                            .copyWith(fontSize: 18)),
                    SizedBox(height: 10.h),
                    Text(
                        "2. Login menggunakan Nama dan Password yang telah didaftarkan",
                        style: AppFontStyle.regularLargeText
                            .copyWith(fontSize: 18)),
                    SizedBox(height: 10.h),
                    Text("3. Pilih menu yang diinginkan",
                        style: AppFontStyle.regularLargeText
                            .copyWith(fontSize: 18)),
                    SizedBox(height: 10.h),
                    Text("4. Tunggu instruksi dari guru",
                        style: AppFontStyle.regularLargeText
                            .copyWith(fontSize: 18)),
                    SizedBox(height: 10.h),
                    Text(
                        "5. Setelah selesai mengerjakan lalu pilih petunjuk dan tap log out",
                        style: AppFontStyle.regularLargeText
                            .copyWith(fontSize: 18)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column _logoutButton(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 12.h, bottom: 12.h),
              ),
              const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text("Keluar",
                  style: AppFontStyle.mediumLargeText
                      .copyWith(color: Colors.white)),
            ],
          ),
          onPressed: () {
            _showPopUp(context);
          },
          height: 80.h,
          width: double.maxFinite,
          backgroundColor: const Color(0XFFEF4444),
          borderRadius: 25,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
              "Keluar dari akun anda?",
              style: AppFontStyle.headline5,
            ),
            content: Text(
              "Apakah Anda yakin ingin logout?",
              style: AppFontStyle.mediumLargeText,
            ),
            actions: [
              Row(
                children: [
                  CustomButton(
                    widget: Text(
                      "Batal",
                      style: AppFontStyle.mediumLargeText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Menutup dialog
                    },
                    height: 70.h,
                    width: 120.w,
                    backgroundColor: Colors.white,
                    borderRadius: 24,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  CustomButton(
                    widget: Text(
                      "Keluar",
                      style: AppFontStyle.mediumLargeText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _authController.signOut().then((_) {
                        if (!_authController.isLoading.value) {
                          Navigator.pushReplacement(
                            context,
                            TransitionFade(
                              child: const LoginAsScreen(),
                            ),
                          );
                        }
                      });
                    },
                    height: 70.h,
                    width: 120.w,
                    backgroundColor: const Color(0XFFEF4444),
                    borderRadius: 24,
                  ),
                ],
              )
            ]);
      },
    );
  }
}
