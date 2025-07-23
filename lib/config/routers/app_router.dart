import 'package:go_router/go_router.dart';

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
