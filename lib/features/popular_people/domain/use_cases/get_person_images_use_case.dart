import 'package:dartz/dartz.dart';
import 'package:movie_stars/core/exceptions/dio_exceptions.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_images_response_entity.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';

class GetPersonImagesUseCase {
  final PeopleRepository peopleRepository;

  GetPersonImagesUseCase({required this.peopleRepository});

  Future<Either<DioExceptions, PersonImagesResponseEntity>> call({
    required int personId,
  }) async {
    return await peopleRepository.getPersonImages(personId: personId);
  }
}
