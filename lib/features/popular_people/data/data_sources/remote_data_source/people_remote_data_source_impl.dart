import 'package:movie_stars/core/constants/remote_urls.dart';
import 'package:movie_stars/core/services/dio_service.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/remote_data_source/people_remote_data_source.dart';
import 'package:movie_stars/features/popular_people/data/models/person_model.dart';

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final DioService dioService;

  PeopleRemoteDataSourceImpl({required this.dioService});
  @override
  Future<List<PersonModel>> getPopularPeople({required int page}) async {
    final List<PersonModel> popularPersons = [];
    try {
      final response = await dioService.get(
        url: 'popular',
        queryParameters: {'api_key': RemoteUrls.apiKey, 'page': page},
      );
      final jsonList = response.data['results'] as List;
      for (final person in jsonList) {
        popularPersons.add(
          PersonModel.fromJson(person as Map<String, dynamic>),
        );
      }
      return popularPersons;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PersonModel> getPersonDetails({required int personId}) async {
    final response = await dioService.get(url: '$personId',queryParameters: {
      'api_key': RemoteUrls.apiKey,
    });
    return PersonModel.fromJson(response.data);
  }
}

