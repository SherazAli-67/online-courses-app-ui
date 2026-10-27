import 'package:flutter/material.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';

class LiveClassScreen extends StatelessWidget {
  const LiveClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(StringConst.liveClass, style: AppTextStyles.sectionTitle),
      ),
    );
  }
}
