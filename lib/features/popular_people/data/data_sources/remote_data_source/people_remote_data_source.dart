import 'package:movie_stars/features/popular_people/data/models/person_model.dart';

abstract class PeopleRemoteDataSource {
  Future<List<PersonModel>> getPopularPeople();
}
