
import 'package:movie_stars/features/popular_people/data/data_sources/remote_data_source/people_remote_data_source.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/remote_data_source/people_remote_data_source_impl.dart';
import 'package:movie_stars/features/popular_people/data/repositories/people_repository_impl.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_popular_people_use_case.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:movie_stars/service_locator.dart';

class PopularPeopleDi {
  final sl = ServiceLocator.getIt;

  Future<void> setup() async {
    sl.registerLazySingleton(
          () => PopularPeopleBloc(
       getPopularPeopleUseCase: sl()
      ),
    );

    sl.registerLazySingleton(
          () => GetPopularPeopleUseCase(
        peopleRepository: sl(),
      ),
    );

    sl.registerLazySingleton<PeopleRepository>(
          () => PeopleRepositoryImpl(
        peopleRemoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<PeopleRemoteDataSource>(
          () => PeopleRemoteDataSourceImpl(
        dioService: sl(),
      ),
    );
  }
}
