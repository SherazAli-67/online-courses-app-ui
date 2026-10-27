import 'package:flutter/material.dart';

class CourseCategoryModel {
  final String title;
  final int lessonCount;
  final String iconPath;
  final Color backgroundColor;

  const CourseCategoryModel({
    required this.title,
    required this.lessonCount,
    required this.iconPath,
    required this.backgroundColor,
  });
}
