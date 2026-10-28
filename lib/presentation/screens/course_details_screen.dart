import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/app_data.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';
import 'package:online_course_app_ui/core/asset_res.dart';
import 'package:online_course_app_ui/core/models/lesson_model.dart';
import 'package:online_course_app_ui/presentation/widgets/app_back_button.dart';
import 'package:online_course_app_ui/presentation/widgets/filter_chip_row.dart';
import 'package:online_course_app_ui/presentation/widgets/progress_ring.dart';
import 'package:provider/provider.dart';

class CourseWeekProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void select(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }
}

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseWeekProvider(),
      child: const _CourseDetailsView(),
    );
  }
}

class _CourseDetailsView extends StatelessWidget {
  const _CourseDetailsView();

  @override
  Widget build(BuildContext context) {
    final weekProvider = context.watch<CourseWeekProvider>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                  AppColors.secondary03,
                  AppColors.scaffoldBgColor,
                AppColors.whiteColor
                ],
              begin: .topRight,
              end: .topLeft
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
              spacing: NumberConstant.contentSpacing,
              children: [
                _buildHeader(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: NumberConstant.contentSpacing,
                    children: [
                      Expanded(child: _buildHeroWithProgress()),
                      FilterChipRow(
                        labels: AppData.courseWeeks,
                        selectedIndex: weekProvider.selectedIndex,
                        onSelected: (index) => context.read<CourseWeekProvider>().select(index),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: NumberConstant.sectionSpacing,
                            children: [
                              _buildLessonListHeader(),
                              _buildLessonTimeline(),
                            ],
                          ),
                        ),
                      )
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

  Widget _buildHeader() {
    return Stack(
      alignment: .center,
      children: [
        const Align(
          alignment: .centerLeft,
          child: AppBackButton(),
        ),
        Text(StringConst.reading, style: AppTextStyles.screenTitle),
      ],
    );
  }

  Widget _buildHeroWithProgress() {
    return Stack(
      alignment: .bottomCenter,
      children: [
        Padding(
          padding: .only(bottom: 100),
          child: Stack(
            alignment: .center,
            children: [
              Image.asset(AssetRes.englishDailyLifeAvatar,),
              Align(
                alignment: const Alignment(-0.75, -0.35),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.secondary03,
                    borderRadius: .circular(NumberConstant.chipRadius),
                  ),
                  child: Padding(
                    padding: .symmetric(
                      horizontal: NumberConstant.chipPaddingH,
                      vertical: NumberConstant.chipPaddingV,
                    ),
                    child: Text(StringConst.hallo, style: AppTextStyles.scheduleLabel),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildProgressCard()
      ],
    );
  }

  Widget _buildProgressCard() {
    final course = AppData.courseDetailsProgress;
    return DecoratedBox(
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
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Expanded(
              child: ProgressRing(
                progress: course.progress,
                percentLabel: '${(course.progress * 100).round()}%',
                trackColor: AppColors.whiteColor.withValues(alpha: 0.35),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: .start,
                spacing: NumberConstant.itemSpacing,
                mainAxisSize: .min,
                children: [
                  Text(course.title, style: AppTextStyles.bannerTitle),
                  Text(course.body, style: AppTextStyles.bannerBody),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonListHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(StringConst.lessonList, style: AppTextStyles.sectionTitle),
        ),
        Padding(
          padding: .all(NumberConstant.tightSpacing),
          child: SvgPicture.asset(
            AssetRes.icDownload,
            colorFilter: .mode(AppColors.primaryColor, .srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonTimeline() {
    final lessons = AppData.lessons;
    return Column(
      children: [
        for (var i = 0; i < lessons.length; i++) ...[
          _buildLessonRow(lesson: lessons[i], index: i),
          if (i < lessons.length - 1) _buildTimelineGap(afterIndex: i),
        ],
      ],
    );
  }

  Widget _buildLessonRow({
    required LessonModel lesson,
    required int index,
  }) {
    return Row(
      spacing: NumberConstant.cardSpacing,
      children: [
        _buildTimelineDot(isCompleted: lesson.isCompleted),
        Expanded(child: _buildLessonCard(lesson, index)),
      ],
    );
  }

  Widget _buildTimelineDot({required bool isCompleted}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.primaryColor : AppColors.navInactiveColor,
        shape: .circle,
      ),
      child: Padding(
        padding: .all(NumberConstant.itemSpacing),
        child: Icon(
          isCompleted ? Icons.check_rounded : Icons.remove_rounded,
          color: AppColors.whiteColor,
          size: 12,
        ),
      ),
    );
  }

  Widget _buildTimelineGap({required int afterIndex}) {
    return SizedBox(
      height: NumberConstant.cardSpacing,
      child: Row(
        children: [
          Stack(
            alignment: .center,
            children: [
              Opacity(
                opacity: 0,
                child: _buildTimelineDot(isCompleted: true),
              ),
              Positioned.fill(
                child: afterIndex == 0
                    ? _buildCompletedConnector()
                    : _buildTimelineLine(AppColors.chipBorderColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedConnector() {
    return Column(
      children: [
        Expanded(child: _buildTimelineLine(AppColors.primaryColor)),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: .circle,
          ),
          child: Padding(padding: .all(NumberConstant.timelineStroke)),
        ),
        Expanded(child: _buildTimelineLine(AppColors.chipBorderColor)),
      ],
    );
  }

  Widget _buildTimelineLine(Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ColoredBox(
            color: color,
            child: SizedBox(
              width: NumberConstant.timelineStroke,
              height: constraints.maxHeight,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLessonCard(LessonModel lesson, int index) {
    final isPrimaryPlay = index.isOdd;
    final playBg = isPrimaryPlay ? AppColors.primaryColor : AppColors.secondary01;
    final playIconColor = isPrimaryPlay ? AppColors.whiteColor : AppColors.primaryColor;
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
        padding: .all(NumberConstant.chipSpacing),
        child: Row(
          spacing: NumberConstant.chipSpacing,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: playBg,
                shape: .circle,
              ),
              child: Padding(
                padding: .all(NumberConstant.itemSpacing + NumberConstant.tightSpacing),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: playIconColor,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: NumberConstant.tightSpacing,
                children: [
                  Text(lesson.title, style: AppTextStyles.lessonTitle),
                  Text(lesson.subtitle, style: AppTextStyles.lessonMeta),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
