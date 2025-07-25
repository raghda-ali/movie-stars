import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_stars/core/exceptions/dio_exceptions.dart';
import 'package:movie_stars/core/network/network_info.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/local_data_source/people_local_data_source.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/remote_data_source/people_remote_data_source.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_images_response_entity.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_response_entity.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource peopleRemoteDataSource;
  final PeopleLocalDataSource peopleLocalDataSource;
  final NetworkInfo networkInfo;

  PeopleRepositoryImpl({
    required this.peopleRemoteDataSource,
    required this.peopleLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<DioExceptions, PersonResponseEntity>> getPopularPeople({
    required int page,
  }) async {
    try {
      if (await networkInfo.isConnected) {
      final response = await peopleRemoteDataSource.getPopularPeople(
        page: page,
      );
      await peopleLocalDataSource.cachePopularPeople(response, page);
      return Right(response);
      } else {
        final localPeople = await peopleLocalDataSource.getCachedPopularPeople(page);
        return Right(localPeople);
      }
    } on DioException catch (e) {
      return Left(e.response!.data!['status_message']);
    }
  }

  @override
  Future<Either<DioExceptions, PersonEntity>> getPersonDetails({
    required int personId,
  }) async {
    try {
      final response = await peopleRemoteDataSource.getPersonDetails(
        personId: personId,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data!['status_message']);
    }
  }

  @override
  Future<Either<DioExceptions, PersonImagesResponseEntity>> getPersonImages({
    required int personId,
  }) async {
    try {
      final response = await peopleRemoteDataSource.getPersonImages(
        personId: personId,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data!['status_message']);
    }
  }
}
