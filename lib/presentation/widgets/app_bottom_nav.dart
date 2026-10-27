import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';
import 'package:online_course_app_ui/core/asset_res.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.whiteColor,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: .all(NumberConstant.navPadding),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              _buildNavItem(
                index: 0,
                iconPath: AssetRes.icHome,
                label: StringConst.navHome,
              ),
              _buildNavItem(
                index: 1,
                iconPath: AssetRes.icExplore,
                label: StringConst.navExplore,
              ),
              _buildNavItem(
                index: 2,
                iconPath: AssetRes.icCourses,
                label: StringConst.navCourses,
              ),
              _buildNavItem(
                index: 3,
                iconPath: AssetRes.icProfile,
                label: StringConst.navProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String label,
  }) {
    final isActive = currentIndex == index;
    final color = isActive ? AppColors.primaryColor : AppColors.navInactiveColor;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: .opaque,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: .min,
          spacing: NumberConstant.tightSpacing,
          children: [
            ColoredBox(
              color: isActive ? AppColors.primaryColor : AppColors.whiteColor,
              child: const SizedBox(height: 2, width: double.infinity),
            ),
            Padding(
              padding: .symmetric(horizontal: NumberConstant.itemSpacing),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: .mode(color, .srcIn),
              ),
            ),
            Text(
              label,
              style: isActive ? AppTextStyles.navLabelActive : AppTextStyles.navLabel,
            ),
          ],
        ),
      ),
    );
  }
}
