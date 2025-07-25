import 'package:movie_stars/features/popular_people/data/models/person_response_model.dart';

abstract class PeopleLocalDataSource {
  Future<void> cachePopularPeople(PersonResponseModel people,int page);
  Future<PersonResponseModel> getCachedPopularPeople(int page);
  Future<int> getLastCachedPage();
}
