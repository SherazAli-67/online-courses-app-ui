import 'package:flutter/material.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/routing/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.scaffoldBgColor,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          onPrimary: AppColors.whiteColor,
          surface: AppColors.scaffoldBgColor,
          onSurface: AppColors.blackColor,
        ),
      ),
      builder: (ctx, child) => child!,
      routerConfig: router,
    );
  }
}
