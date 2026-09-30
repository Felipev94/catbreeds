import 'package:catbreeds/app/ui/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../cats/ui/home/view/cats_screen.dart';

abstract final class AppNavigation {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.CATS,
    routes: [
      GoRoute(
        path: AppRoutes.CATS,
        builder: (context, state) => CatsScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.CAT_DETAIL,
            builder: (context, state) {
              // TODO(uncomment-code): When the cat detail screen will available.
              // final String catId = state.pathParameters['catId'] ?? '';
              return Container();
            },
          ),
        ],
      ),
    ],
  );

  static void pushToCatDetail(BuildContext context, String catId) {
    context.go(AppRoutes.catDetailPath(catId));
  }
}
