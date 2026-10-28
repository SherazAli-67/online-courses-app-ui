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
            _AnimatedFilterChip(
              label: labels[i],
              selected: i == selectedIndex,
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}

class _AnimatedFilterChip extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AnimatedFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_AnimatedFilterChip> createState() => _AnimatedFilterChipState();
}

class _AnimatedFilterChipState extends State<_AnimatedFilterChip> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: NumberConstant.animFastMs);
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      behavior: .opaque,
      child: AnimatedScale(
        scale: _pressed ? NumberConstant.pressScale : 1,
        duration: duration,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: widget.selected ? AppColors.primaryColor : AppColors.whiteColor,
            borderRadius: .circular(NumberConstant.chipRadius),
          ),
          padding: .symmetric(
            horizontal: NumberConstant.chipPaddingH,
            vertical: NumberConstant.chipPaddingV,
          ),
          child: AnimatedDefaultTextStyle(
            duration: duration,
            curve: Curves.easeOutCubic,
            style: widget.selected
                ? AppTextStyles.chipLabelActive
                : AppTextStyles.chipLabel,
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
