import 'package:flutter/material.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(StringConst.activities, style: AppTextStyles.sectionTitle),
      ),
    );
  }
}
