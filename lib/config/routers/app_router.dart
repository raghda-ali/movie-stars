import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_stars/core/constants/route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        // name: RouteNames.homePage,
        // builder: (context, state) => const PopularPeoplePage(),
      ),
    ],
  );
}
