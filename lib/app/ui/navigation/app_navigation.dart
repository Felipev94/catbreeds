import 'package:catbreeds/app/ui/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../cats/ui/cat_detail/view/cat_detail_screen.dart';
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
              final String catId = state.pathParameters['catId'] ?? '';
              return CatDetailScreen(catId: catId);
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
