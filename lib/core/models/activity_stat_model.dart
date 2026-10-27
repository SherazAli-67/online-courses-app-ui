import 'package:flutter/material.dart';

class ActivityStatModel {
  final String title;
  final String goalSubtitle;
  final int current;
  final int total;
  final String iconPath;
  final Color iconBackgroundColor;
  final Color progressColor;

  const ActivityStatModel({
    required this.title,
    required this.goalSubtitle,
    required this.current,
    required this.total,
    required this.iconPath,
    required this.iconBackgroundColor,
    required this.progressColor,
  });
}
