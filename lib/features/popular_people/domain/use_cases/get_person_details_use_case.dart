import 'package:dartz/dartz.dart';
import 'package:movie_stars/core/exceptions/dio_exceptions.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';

class GetPersonDetails {
  final PeopleRepository peopleRepository;

  GetPersonDetails({required this.peopleRepository});

  Future<Either<DioExceptions, PersonEntity>> call({
    required int personId,
  }) async {
    return await peopleRepository.getPersonDetails(personId: personId);
  }
}
