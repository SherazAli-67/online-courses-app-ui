import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';
import 'package:online_course_app_ui/presentation/screens/activities_screen.dart';
import 'package:online_course_app_ui/presentation/screens/course_details_screen.dart';
import 'package:online_course_app_ui/presentation/screens/explore_screen.dart';
import 'package:online_course_app_ui/presentation/screens/home_screen.dart';
import 'package:online_course_app_ui/presentation/screens/live_class_screen.dart';
import 'package:online_course_app_ui/presentation/screens/main_shell_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainShellScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.home.routeName,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.explore.routeName,
              builder: (context, state) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.courses.routeName,
              builder: (context, state) => const LiveClassScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.profile.routeName,
              builder: (context, state) => const ActivitiesScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: NamedRoutes.courseDetails.routeName,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CourseDetailsScreen(),
        transitionDuration: const Duration(milliseconds: NumberConstant.animNormalMs),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    ),
  ],
);

enum NamedRoutes {
  home('/home'),
  explore('/explore'),
  courses('/courses'),
  profile('/profile'),
  courseDetails('/course-details');

  final String routeName;
  const NamedRoutes(this.routeName);
}
