import 'package:get_it/get_it.dart';
import 'package:movie_stars/features/popular_people/popular_people_di.dart';

import 'core/services/dio_service.dart';

class ServiceLocator {
  ServiceLocator._();

  static GetIt getIt = GetIt.instance;
}

Future<void> setupLocator() async {
  final sl = ServiceLocator.getIt;

  sl.registerLazySingleton(() => DioService(dio: sl()));

  await PopularPeopleDi().setup();
}
