import 'package:dartz/dartz.dart';
import 'package:movie_stars/core/exceptions/dio_exceptions.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_response_entity.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';

class GetPopularPeopleUseCase {
  final PeopleRepository peopleRepository;

  GetPopularPeopleUseCase({required this.peopleRepository});

  Future<Either<DioExceptions, PersonResponseEntity>> call({
    required int page,
  }) async {
    return await peopleRepository.getPopularPeople(page: page);
  }
}
