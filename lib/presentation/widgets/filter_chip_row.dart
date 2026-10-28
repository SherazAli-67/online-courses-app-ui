import 'package:flutter/material.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';

class FilterChipRow extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FilterChipRow({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: NumberConstant.chipSpacing,
        children: [
          for (var i = 0; i < labels.length; i++)
            GestureDetector(
              onTap: () => onSelected(i),
              behavior: .opaque,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: i == selectedIndex ? AppColors.primaryColor : AppColors.whiteColor,
                  borderRadius: .circular(NumberConstant.chipRadius),
                  // border: i == selectedIndex ? null : .all(color: AppColors.chipBorderColor),
                ),
                child: Padding(
                  padding: .symmetric(
                    horizontal: NumberConstant.chipPaddingH,
                    vertical: NumberConstant.chipPaddingV,
                  ),
                  child: Text(
                    labels[i],
                    style: i == selectedIndex ? AppTextStyles.chipLabelActive : AppTextStyles.chipLabel,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
