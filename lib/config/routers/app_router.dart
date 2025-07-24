import 'package:go_router/go_router.dart';
import 'package:movie_stars/core/constants/route_names.dart';
import 'package:movie_stars/core/constants/router_paths.dart';
import 'package:movie_stars/features/popular_people/presentation/pages/person_basic_info_page.dart';

import '../../features/popular_people/presentation/pages/popular_people_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.popularPeoplePage,
        builder: (context, state) => const PopularPeoplePage(),
      ),
      GoRoute(
        path: RouterPaths.personBasicInfo,
        name: RouteNames.personBasicInfoPage,
        builder: (context, state) {
          final personId = state.pathParameters['id']!;
          return PersonBasicInfoPage(personId: int.parse(personId));
        },
      ),
    ],
  );
}
