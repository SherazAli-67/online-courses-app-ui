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

  const ProgressRing({
    super.key,
    required this.progress,
    required this.percentLabel,
    this.style = AppTextStyles.progressPercent,
    this.progressColor = AppColors.whiteColor,
    this.trackColor = AppColors.secondary01,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _ProgressRingPainter(
          progress: progress.clamp(0, 1),
          progressColor: progressColor,
          trackColor: trackColor,
          strokeWidth: NumberConstant.progressRingStroke,
        ),
        child: Center(
          child: Text(percentLabel, style: style),
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

  _ProgressRingPainter({
    required this.progress,
    required this.progressColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final trackPaint = Paint()
      ..color = trackColor.withValues(alpha: 0.35)
      ..style = .stroke
      ..strokeWidth = strokeWidth / 2
      ..strokeCap = .round;
    final progressPaint = Paint()
      ..color = progressColor
      ..style = .stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = .round;
    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
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
        oldDelegate.strokeWidth != strokeWidth;
  }
}
