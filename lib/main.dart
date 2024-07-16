import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz/binding/binding.dart';
import 'package:quiz/ui/add_materi_teacher/add_materi_teacher_screen.dart';
import 'package:quiz/ui/auth/login_as/login_as_screen.dart';
import 'package:quiz/ui/auth/login_student/login_student_screen.dart';
import 'package:quiz/ui/auth/login_teacher/login_teacher_screen.dart';
import 'package:quiz/ui/auth/register_student/register_student_screen.dart';
import 'package:quiz/ui/auth/register_teacher/register_teacher_screen.dart';
import 'package:quiz/ui/splash/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //initialize Hive database

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // initial screen size on portrait mode
      designSize: const Size(428, 926),
      builder: (context, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Ubuntu",
          useMaterial3: true,
        ),
        initialBinding: AppBindings(),
        home: const SplashScreen(),
        getPages: [
          GetPage(name: '/login_as', page: () => const LoginAsScreen()),
          GetPage(
              name: '/login_teacher', page: () => const LoginTeacherScreen()),
          GetPage(
              name: '/login_student', page: () => const LoginStudentScreen()),
          GetPage(
              name: '/register_teacher',
              page: () => const RegisterTeacherScreen()),
          GetPage(
              name: '/register_student',
              page: () => const RegisterStudentScreen()),
          GetPage(
            name: '/add-materi',
            page: () => const AddMateriTeacherScreen(),
          ),
        ],
      ),
    );
  }
}
