import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final String percentLabel;
  final TextStyle style;
  final Color progressColor;
  final Color trackColor;
  final double? strokeWidth;
  final double? trackStrokeWidth;
  final double progressOutset;
  final Widget? center;

  const ProgressRing({
    super.key,
    required this.progress,
    required this.percentLabel,
    this.style = AppTextStyles.progressPercent,
    this.progressColor = AppColors.whiteColor,
    this.trackColor = AppColors.secondary01,
    this.strokeWidth,
    this.trackStrokeWidth,
    this.progressOutset = 0,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    final progressStroke = strokeWidth ?? NumberConstant.progressRingStroke;
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _ProgressRingPainter(
          progress: progress.clamp(0, 1),
          progressColor: progressColor,
          trackColor: trackColor,
          strokeWidth: progressStroke,
          trackStrokeWidth: trackStrokeWidth ?? progressStroke / 2,
          progressOutset: progressOutset,
        ),
        child: Center(
          child: center ?? Text(percentLabel, style: style),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color trackColor;
  final double strokeWidth;
  final double trackStrokeWidth;
  final double progressOutset;

  _ProgressRingPainter({
    required this.progress,
    required this.progressColor,
    required this.trackColor,
    required this.strokeWidth,
    required this.trackStrokeWidth,
    required this.progressOutset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final minSide = math.min(size.width, size.height);
    final progressRadius = (minSide - strokeWidth) / 2;
    final trackRadius = progressOutset > 0
        ? progressRadius - progressOutset - trackStrokeWidth / 2
        : progressRadius;
    final trackPaint = Paint()
      ..color = trackColor
      ..style = .stroke
      ..strokeWidth = trackStrokeWidth
      ..strokeCap = .round;
    final progressPaint = Paint()
      ..color = progressColor
      ..style = .stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = .round;
    canvas.drawCircle(center, trackRadius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: progressRadius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackStrokeWidth != trackStrokeWidth ||
        oldDelegate.progressOutset != progressOutset;
  }
}
