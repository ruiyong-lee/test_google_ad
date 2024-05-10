import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_google_ad/second_screen.dart';

import 'first_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/first',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/first',
      pageBuilder: (context, state) => const NoTransitionPage(child: FirstScreen()),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/second',
      pageBuilder: (context, state) => const NoTransitionPage(child: SecondScreen()),
    )
  ],
);
