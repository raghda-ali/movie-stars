import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_stars/core/network/network_info.dart';
import 'package:movie_stars/features/popular_people/popular_people_di.dart';

import 'core/services/dio_service.dart';

class ServiceLocator {
  ServiceLocator._();

  static GetIt getIt = GetIt.instance;
}

Future<void> setupLocator() async {
  final sl = ServiceLocator.getIt;

  sl.registerLazySingleton(() => DioService(dio: sl()));
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  await PopularPeopleDi().setup();
}
