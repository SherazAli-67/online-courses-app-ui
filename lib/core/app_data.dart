import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/asset_res.dart';
import 'package:online_course_app_ui/core/models/activity_stat_model.dart';
import 'package:online_course_app_ui/core/models/continue_course_model.dart';
import 'package:online_course_app_ui/core/models/course_category_model.dart';
import 'package:online_course_app_ui/core/models/lesson_model.dart';
import 'package:online_course_app_ui/core/models/live_class_model.dart';

class AppData {
  static const continueCourse = ContinueCourseModel(
    title: StringConst.speaking,
    body: StringConst.continueBannerBody,
    progress: 0.75,
  );

  static const courseCategories = [
    CourseCategoryModel(
      title: StringConst.listening,
      lessonCount: 18,
      iconPath: AssetRes.icHeadphones,
      backgroundColor: AppColors.listeningCardColor,
    ),
    CourseCategoryModel(
      title: StringConst.reading,
      lessonCount: 12,
      iconPath: AssetRes.icReadingBook,
      backgroundColor: AppColors.readingCardColor,
    ),
    CourseCategoryModel(
      title: StringConst.speaking,
      lessonCount: 24,
      iconPath: AssetRes.icSpeaking,
      backgroundColor: AppColors.speakingCardColor,
    ),
    CourseCategoryModel(
      title: StringConst.writing,
      lessonCount: 22,
      iconPath: AssetRes.icWriting,
      backgroundColor: AppColors.writingCardColor,
    ),
  ];

  static const liveClassFilters = [
    StringConst.filterAllTime,
    StringConst.filterLastWeek,
    StringConst.filterDayTime,
    StringConst.filterWeekend,
  ];

  static const liveClasses = [
    LiveClassModel(
      title: StringConst.englishBasic,
      schedule: StringConst.englishBasicSchedule,
      imagePath: AssetRes.englishBasicAvatar,
      startColor: AppColors.secondary03,
      endColor: AppColors.secondary01,
    ),
    LiveClassModel(
      title: StringConst.englishInDailyLife,
      schedule: StringConst.englishDailyLifeSchedule,
      imagePath: AssetRes.englishDailyLifeAvatar,
      startColor: AppColors.secondary02,
      endColor: AppColors.secondary04,
    ),
    LiveClassModel(
      title: StringConst.communication,
      schedule: StringConst.communicationSchedule,
      imagePath: AssetRes.communicationAvatar,
      startColor: AppColors.listeningCardColor,
      endColor: AppColors.avatarBgColor,
    ),
  ];

  static const courseWeeks = [
    StringConst.week01,
    StringConst.week02,
    StringConst.week03,
    StringConst.week04,
  ];

  static const courseDetailsProgress = ContinueCourseModel(
    title: StringConst.reading,
    body: StringConst.continueBannerBody,
    progress: 0.95,
  );

  static const lessons = [
    LessonModel(
      title: StringConst.introCourse,
      subtitle: StringConst.introCourseMeta,
      isCompleted: true,
    ),
    LessonModel(
      title: StringConst.basicBuildingBlocks,
      subtitle: StringConst.basicBuildingBlocksMeta,
      isCompleted: false,
    ),
    LessonModel(
      title: StringConst.aboutSubjectVerbs,
      subtitle: StringConst.aboutSubjectVerbsMeta,
      isCompleted: false,
    ),
  ];

  static const activityProgress = 0.15;
  static const activityStreakTime = StringConst.activityStreakTime;
  static const totalHoursValue = StringConst.totalHoursValue;

  static const activityStats = [
    ActivityStatModel(
      title: StringConst.totalHoursSpent,
      goalSubtitle: StringConst.get100Stars,
      current: 7,
      total: 100,
      iconPath: AssetRes.icStreakHours,
      iconBackgroundColor: AppColors.secondary03,
      progressColor: AppColors.secondary01,
    ),
    ActivityStatModel(
      title: StringConst.totalQuizComplete,
      goalSubtitle: StringConst.get20Stars,
      current: 17,
      total: 20,
      iconPath: AssetRes.icQuizCrown,
      iconBackgroundColor: AppColors.secondary04,
      progressColor: AppColors.secondary01,
    ),
    ActivityStatModel(
      title: StringConst.totalAssignment,
      goalSubtitle: StringConst.get20Stars,
      current: 7,
      total: 20,
      iconPath: AssetRes.icTotalAssignment,
      iconBackgroundColor: AppColors.listeningCardColor,
      progressColor: AppColors.secondary01,
    ),
  ];
}
