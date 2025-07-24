import 'package:dartz/dartz.dart';
import 'package:movie_stars/core/exceptions/dio_exceptions.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_images_response_entity.dart';

abstract class PeopleRepository {
  Future<Either<DioExceptions, List<PersonEntity>>> getPopularPeople({
    required int page,
  });
  Future<Either<DioExceptions, PersonEntity>> getPersonDetails({
    required int personId,
  });
  Future<Either<DioExceptions, PersonImagesResponseEntity>> getPersonImages({
    required int personId,
  });
}
