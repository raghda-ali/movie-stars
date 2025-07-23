import 'package:go_router/go_router.dart';
import 'package:movie_stars/core/constants/route_names.dart';

import '../../features/popular_people/presentation/pages/popular_people_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.popularPeoplePage,
        builder: (context, state) => const PopularPeoplePage(),
      ),
    ],
  );
}
