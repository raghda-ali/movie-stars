import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_stars/bloc_providers.dart';
import 'package:movie_stars/config/routers/app_router.dart';
import 'package:movie_stars/config/themes/app_theme.dart';
import 'package:movie_stars/service_locator.dart';

Future main() async {
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp.router(
        title: 'Movie Stars',
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
