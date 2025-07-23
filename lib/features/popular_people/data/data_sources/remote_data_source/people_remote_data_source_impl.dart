import 'package:dio/dio.dart';
import 'package:movie_stars/core/services/dio_service.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/remote_data_source/people_remote_data_source.dart';
import 'package:movie_stars/features/popular_people/data/models/person_model.dart';

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource{
  final DioService dioService;

  PeopleRemoteDataSourceImpl({required this.dioService,});
  @override
  Future<List<PersonModel>> getPopularPeople() async{
    final List<PersonModel> popularPersons = [];
    try {
      final Response response = await dioService.get(
        url: '/person/popular',
      );
      final jsonList = response.data['data'] as List;
      for (final person in jsonList) {
        popularPersons.add(
          PersonModel.fromJson(
            person as Map<String, dynamic>,
          ),
        );
      }
      return popularPersons;
    } catch (e) {
      rethrow;
    }
  }
}