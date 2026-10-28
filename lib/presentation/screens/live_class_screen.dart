import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/constants/string_const.dart';
import 'package:online_course_app_ui/core/app_colors.dart';
import 'package:online_course_app_ui/core/app_data.dart';
import 'package:online_course_app_ui/core/app_textstyles.dart';
import 'package:online_course_app_ui/core/asset_res.dart';
import 'package:online_course_app_ui/core/models/live_class_model.dart';
import 'package:online_course_app_ui/presentation/widgets/app_back_button.dart';
import 'package:online_course_app_ui/presentation/widgets/filter_chip_row.dart';
import 'package:online_course_app_ui/presentation/widgets/press_scale.dart';
import 'package:online_course_app_ui/presentation/widgets/staggered_fade_slide.dart';
import 'package:online_course_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class LiveClassFilterProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void select(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }
}

class LiveClassScreen extends StatelessWidget {
  const LiveClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LiveClassFilterProvider(),
      child: const _LiveClassView(),
    );
  }
}

class _LiveClassView extends StatelessWidget {
  const _LiveClassView();

  @override
  Widget build(BuildContext context) {
    final filterProvider = context.watch<LiveClassFilterProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(
            NumberConstant.horizontalPadding,
            NumberConstant.screenTopPadding,
            NumberConstant.horizontalPadding,
            0,
          ),
          child: Column(
            crossAxisAlignment: .start,
            spacing: NumberConstant.sectionSpacing,
            children: [
              StaggeredFadeSlide(
                index: 0,
                child: _buildHeader(context),
              ),
              Expanded(
                child: ListView(
                  padding: .only(bottom: NumberConstant.navPadding),
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      spacing: NumberConstant.contentSpacing,
                      children: [
                        StaggeredFadeSlide(
                          index: 1,
                          child: Text(
                            StringConst.bookYourLiveClass,
                            style: AppTextStyles.sectionTitle,
                          ),
                        ),
                        StaggeredFadeSlide(
                          index: 2,
                          child: FilterChipRow(
                            labels: AppData.liveClassFilters,
                            selectedIndex: filterProvider.selectedIndex,
                            onSelected: (index) =>
                                context.read<LiveClassFilterProvider>().select(index),
                          ),
                        ),
                        Column(
                          spacing: NumberConstant.cardSpacing,
                          children: [
                            for (var i = 0; i < AppData.liveClasses.length; i++)
                              StaggeredFadeSlide(
                                index: 3 + i,
                                child: _buildLiveClassCard(AppData.liveClasses[i]),
                              ),
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
        Text(StringConst.liveClass, style: AppTextStyles.screenTitle),
      ],
    );
  }

  Widget _buildLiveClassCard(LiveClassModel liveClass) {
    return PressScale(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: .circular(NumberConstant.bannerRadius),
          gradient: LinearGradient(
            begin: .centerLeft,
            end: .centerRight,
            colors: [liveClass.startColor, liveClass.endColor],
          ),
          image: DecorationImage(
            image: AssetImage(AssetRes.bannerBg),
            fit: .cover,
          ),
        ),
        child: Row(
          spacing: NumberConstant.itemSpacing,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const .symmetric(
                  horizontal: NumberConstant.cardPaddingH,
                  vertical: NumberConstant.cardPaddingV,
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: NumberConstant.cardSpacing,
                  children: [
                    Text(liveClass.title, style: AppTextStyles.screenTitle),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: .circular(NumberConstant.chipRadius),
                      ),
                      child: Padding(
                        padding: .symmetric(
                          horizontal: NumberConstant.chipPaddingH,
                          vertical: NumberConstant.chipPaddingV,
                        ),
                        child: Row(
                          mainAxisSize: .min,
                          spacing: NumberConstant.tightSpacing,
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              color: AppColors.primaryColor,
                              size: 14,
                            ),
                            Text(liveClass.schedule, style: AppTextStyles.scheduleLabel),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      spacing: NumberConstant.tightSpacing,
                      children: [
                        Text(StringConst.bookNow, style: AppTextStyles.bookNow),
                        SvgPicture.asset(
                          AssetRes.icArrowNext,
                          colorFilter: .mode(AppColors.primaryColor, .srcIn),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(liveClass.imagePath, fit: .contain),
            ),
          ],
        ),
      ),
    );
  }
}
