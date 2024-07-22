import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/common/theme/app_font_style.dart';
import 'package:quiz/common/utils/transition_fade.dart';
import 'package:quiz/common/widgets/custom_button.dart';
import 'package:quiz/common/widgets/custom_field_form.dart';
import 'package:quiz/common/widgets/custom_field_form_password.dart';
import 'package:quiz/controller/auth_controller.dart';
import 'package:quiz/ui/auth/login_teacher/login_teacher_screen.dart';

class RegisterTeacherContent extends StatefulWidget {
  const RegisterTeacherContent({super.key});

  @override
  State<RegisterTeacherContent> createState() => _RegisterTeacherContentState();
}

class _RegisterTeacherContentState extends State<RegisterTeacherContent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _classController.dispose();
    _passwordController.dispose();
  }

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
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Daftar", style: AppFontStyle.headline6.copyWith(fontSize: 40)),
          SizedBox(
            height: 10.h,
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.center,
              heightFactor: 0.8,
              widthFactor: 1.0,
              child: Image.asset("assets/images/loginMenu.png"),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Daftar Sebagai Guru",
            style: AppFontStyle.mediumLargeText,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomFieldForm(
              controller: _nameController,
              hintText: "Nama",
              maxLines: 1,
              obscureText: false,
              isEnabled: true,
              alphabetOnly: false,
              numberOnly: false),
          SizedBox(
            height: 10.h,
          ),
          CustomFieldForm(
              controller: _classController,
              hintText: "Kelas",
              maxLines: 1,
              obscureText: false,
              isEnabled: true,
              alphabetOnly: false,
              numberOnly: false)
        ]),
        SizedBox(
          height: 10.h,
        ),
        PasswordPrefixTextField(
            controller: _passwordController,
            hintText: "Password",
            maxLines: 1,
            obscureText: true,
            isEnabled: true,
            alphabetOnly: false,
            numberOnly: false),
        SizedBox(
          height: 20.h,
        ),
        CustomButton(
          widget: Obx(() => _authController.isLoading.value
              ? const CircularProgressIndicator()
              : Text("Daftar", style: AppFontStyle.mediumLargeText)),
          onPressed: () {
            _authController
                .signUp(
              _nameController.text,
              _passwordController.text,
              _classController.text,
            )
                .then((_) {
              if (!_authController.isLoading.value) {
                _showPopUp();
              }
            });
          },
          height: 80.h,
          width: double.maxFinite,
          backgroundColor: const Color(0XFFBDF565),
          borderRadius: 10,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  void _showPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
              "Berhasil Mendaftar sebagai Guru",
              style: AppFontStyle.headline6,
            ),
            actions: [
              CustomButton(
                  widget: Text(
                    "OKE",
                    style: AppFontStyle.largeTextBold,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        TransitionFade(child: const LoginTeacherScreen()));
                  },
                  height: 70.h,
                  width: double.maxFinite,
                  backgroundColor: const Color(0XFFBDF565),
                  borderRadius: 35)
            ]);
      },
    );
  }
}
