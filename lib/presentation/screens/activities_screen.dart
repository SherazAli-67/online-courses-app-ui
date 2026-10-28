import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/app_data.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';
import 'package:online_course_app_ui/core/asset_res.dart';
import 'package:online_course_app_ui/core/models/activity_stat_model.dart';
import 'package:online_course_app_ui/presentation/widgets/app_back_button.dart';
import 'package:online_course_app_ui/presentation/widgets/progress_ring.dart';
import 'package:online_course_app_ui/routing/router.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  AppColors.secondary03,
                  AppColors.scaffoldBgColor
                ],
                begin: .topRight,
                end: .center
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: .fromLTRB(
              NumberConstant.horizontalPadding,
              NumberConstant.screenTopPadding,
              NumberConstant.horizontalPadding,
              0,
            ),
            child: Column(
              spacing: NumberConstant.sectionSpacing,
              children: [
                _buildHeader(context),
                Expanded(
                  child: ListView(
                    padding: .only(bottom: NumberConstant.navPadding),
                    children: [
                      Column(
                        spacing: NumberConstant.contentSpacing,
                        children: [
                          _buildStreakRing(),
                          _buildHoursBanner(),
                          Column(
                            spacing: NumberConstant.cardSpacing,
                            children: [
                              for (final stat in AppData.activityStats) _buildStatCard(stat),
                            ],
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        Align(
          alignment: .centerLeft,
          child: AppBackButton(onTap: () => context.go(NamedRoutes.home.routeName)),
        ),
        Text(StringConst.activities, style: AppTextStyles.screenTitle),
      ],
    );
  }

  Widget _buildStreakRing() {
    final percentLabel = '${(AppData.activityProgress * 100).round()}%';
    return Align(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: .circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withValues(alpha: 0.08),
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                ),
              ],
            ),
            child: Padding(
              padding: .all(NumberConstant.cardPaddingV),
              child: ProgressRing(
                progress: AppData.activityProgress,
                percentLabel: percentLabel,
                progressColor: AppColors.primaryColor,
                trackColor: AppColors.secondary04,
                strokeWidth: NumberConstant.activitiesProgressStroke,
                trackStrokeWidth: NumberConstant.activitiesTrackStroke,
                progressOutset: NumberConstant.activitiesProgressOutset,
                center: Column(
                  mainAxisSize: .min,
                  spacing: NumberConstant.tightSpacing,
                  children: [
                    SvgPicture.asset(AssetRes.icStreakHours),
                    Text(percentLabel, style: AppTextStyles.activityPercent),
                    Text(AppData.activityStreakTime, style: AppTextStyles.activityTime),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoursBanner() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: .circular(NumberConstant.activityCardRadius),
      ),
      child: Padding(
        padding: .all(NumberConstant.navPadding),
        child: Row(
          children: [
            Expanded(
              child: Text(StringConst.totalHoursSpent, style: AppTextStyles.hoursBanner),
            ),
            Text(AppData.totalHoursValue, style: AppTextStyles.hoursBanner),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(ActivityStatModel stat) {
    final progress = stat.total == 0 ? 0.0 : stat.current / stat.total;
    final progressLabel =
        '${stat.current.toString().padLeft(2, '0')}/${stat.total.toString().padLeft(stat.total >= 100 ? 3 : 2, '0')}';
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .circular(NumberConstant.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.06),
            offset: const Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Padding(
        padding: .fromLTRB(14, 14, 13, 13),
        child: Row(
          spacing: NumberConstant.chipSpacing,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: stat.iconBackgroundColor,
                borderRadius: .circular(NumberConstant.cardRadius),
              ),
              child: Padding(
                padding: .all(NumberConstant.cardPaddingH),
                child: SvgPicture.asset(stat.iconPath),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: NumberConstant.itemSpacing,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    spacing: NumberConstant.tightSpacing,
                    children: [
                      Text(stat.title, style: AppTextStyles.activityCardTitle),
                      Text(stat.goalSubtitle, style: AppTextStyles.activityCardSubtitle),
                    ],
                  ),
                  Row(
                    spacing: NumberConstant.itemSpacing,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: .circular(NumberConstant.cardRadius),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: NumberConstant.timelineStroke * 3.5,
                            backgroundColor: AppColors.chipBorderColor,
                            color: stat.progressColor,
                          ),
                        ),
                      ),
                      Text(progressLabel, style: AppTextStyles.activityProgress),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
