import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_stars/core/exceptions/dio_exceptions.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/remote_data_source/people_remote_data_source.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource peopleRemoteDataSource;

  PeopleRepositoryImpl({required this.peopleRemoteDataSource});

  @override
  Future<Either<DioExceptions, List<PersonEntity>>> getPopularPeople({
    required int page,
  }) async {
    try {
      final response = await peopleRemoteDataSource.getPopularPeople(
        page: page,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data!);
    }
  }
}
