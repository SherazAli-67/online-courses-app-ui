import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/app_data.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';
import 'package:online_course_app_ui/core/asset_res.dart';
import 'package:online_course_app_ui/core/models/course_category_model.dart';
import 'package:online_course_app_ui/presentation/widgets/progress_ring.dart';
import 'package:online_course_app_ui/routing/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(
            NumberConstant.horizontalPadding,
            NumberConstant.screenTopPadding,
            NumberConstant.horizontalPadding,
            0,
          ),
          child: ListView(
            padding: .only(bottom: NumberConstant.navPadding),
            children: [
              Column(
                crossAxisAlignment: .start,
                spacing: NumberConstant.sectionSpacing,
                children: [
                  _buildHeader(),
                  _buildContinueBanner(context),
                  Column(
                    crossAxisAlignment: .start,
                    spacing: NumberConstant.contentSpacing,
                    children: [
                      Text(StringConst.courseList, style: AppTextStyles.sectionTitle),
                      _buildCourseGrid(context),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      spacing: NumberConstant.itemSpacing + NumberConstant.tightSpacing,
      children: [
        ClipRRect(
          borderRadius: .circular(NumberConstant.avatarRadius),
          child: ColoredBox(
            color: AppColors.avatarBgColor,
            child: Image.asset(
              AssetRes.profileAvatar,
              fit: .cover,
              width: 58,
              height: 58,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: NumberConstant.tightSpacing,
            children: [
              Row(
                spacing: NumberConstant.tightSpacing,
                children: [
                  Flexible(child: Text(StringConst.greetingName, style: AppTextStyles.greeting)),
                  SvgPicture.asset(AssetRes.icWaveHand),
                ],
              ),
              Text(StringConst.greetingSubtitle, style: AppTextStyles.body),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContinueBanner(BuildContext context) {
    final course = AppData.continueCourse;
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.courseDetails.routeName),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: .circular(NumberConstant.bannerRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.1),
              offset: const Offset(4, 12),
              blurRadius: 32,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(AssetRes.bannerBg),
            fit: .cover,
          ),
        ),
        child: Padding(
          padding: .all(NumberConstant.cardPaddingV),
          child: Row(
            spacing: NumberConstant.cardSpacing,
            children: [
              Expanded(
                child: ProgressRing(
                  progress: course.progress,
                  percentLabel: '${(course.progress * 100).round()}%',
                  trackColor: AppColors.whiteColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: NumberConstant.chipSpacing,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      spacing: NumberConstant.itemSpacing,
                      children: [
                        Text(course.title, style: AppTextStyles.bannerTitle),
                        Text(course.body, style: AppTextStyles.bannerBody),
                      ],
                    ),
                    Row(
                      spacing: NumberConstant.tightSpacing,
                      children: [
                        Text(StringConst.continueLesson, style: AppTextStyles.continueCta),
                        SvgPicture.asset(
                          AssetRes.icArrowNext,
                          colorFilter: .mode(AppColors.whiteColor, .srcIn),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseGrid(BuildContext context) {
    final categories = AppData.courseCategories;
    return Row(
      crossAxisAlignment: .start,
      spacing: NumberConstant.cardSpacing,
      children: [
        Expanded(
          child: Column(
            spacing: NumberConstant.cardSpacing,
            children: [
              _buildCourseCategoryCard(context, categories[0], isTall: true),
              _buildCourseCategoryCard(context, categories[2], isTall: false),
            ],
          ),
        ),
        Expanded(
          child: Column(
            spacing: NumberConstant.cardSpacing,
            children: [
              _buildCourseCategoryCard(context, categories[1], isTall: false),
              _buildCourseCategoryCard(context, categories[3], isTall: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCategoryCard(
    BuildContext context,
    CourseCategoryModel category, {
    required bool isTall,
  }) {
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.courseDetails.routeName),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: .circular(NumberConstant.cardRadius),
        ),
        child: Padding(
          padding: .symmetric(
            horizontal: NumberConstant.cardPaddingH,
            vertical: NumberConstant.cardPaddingV,
          ),
          child: Column(
            crossAxisAlignment: .start,
            spacing: isTall
                ? NumberConstant.courseCardSpacingTall
                : NumberConstant.courseCardSpacingShort,
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: .circle,
                ),
                child: Padding(
                  padding: .all(NumberConstant.iconCirclePadding),
                  child: SvgPicture.asset(category.iconPath),
                ),
              ),
              Row(
                crossAxisAlignment: .end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: NumberConstant.itemSpacing,
                      children: [
                        Text(category.title, style: AppTextStyles.cardTitle),
                        Text(
                          '${category.lessonCount} ${StringConst.lessonsSuffix}',
                          style: AppTextStyles.cardSubtitle,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    AssetRes.icArrowNext,
                    colorFilter: .mode(AppColors.blackColor, .srcIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
