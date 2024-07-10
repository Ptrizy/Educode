import 'package:flutter/material.dart';
import 'package:quiz/ui/auth/login_student/widgets/login_student_content.dart';

class LoginStudentScreen extends StatelessWidget {
  const LoginStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 12,
          bottom: 12,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [LoginStudentContent()],
          ),
        ),
      ),
    ));
  }
}
