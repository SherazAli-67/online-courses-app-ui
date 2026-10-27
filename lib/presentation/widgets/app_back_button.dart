import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/core/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap ?? () => context.pop(),
        child: Padding(
          padding: .all(NumberConstant.backButtonPadding),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.bodyTextColor,
          ),
        ),
      ),
    );
  }
}
