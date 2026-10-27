import 'package:flutter/material.dart';

class LiveClassModel {
  final String title;
  final String schedule;
  final String imagePath;
  final Color startColor;
  final Color endColor;

  const LiveClassModel({
    required this.title,
    required this.schedule,
    required this.imagePath,
    required this.startColor,
    required this.endColor,
  });
}
