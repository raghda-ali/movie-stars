import 'package:movie_stars/features/popular_people/data/models/person_model.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_images_response_entity.dart';

abstract class PeopleRemoteDataSource {
  Future<List<PersonModel>> getPopularPeople({required int page});
  Future<PersonModel> getPersonDetails({required int personId});
  Future<PersonImagesResponseEntity> getPersonImages({required int personId});
}
