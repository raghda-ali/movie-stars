import 'package:movie_stars/features/popular_people/data/models/person_model.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_response_entity.dart';

class PersonResponseModel extends PersonResponseEntity {
  PersonResponseModel({
    required super.results,
    required super.totalPages,
    required super.page,
  });
  factory PersonResponseModel.fromJson(Map<String, dynamic> json) {
    return PersonResponseModel(
      results: List<PersonModel>.from(
        json['results'].map((e) => PersonModel.fromJson(e)),
      ),
      totalPages: json['total_pages'],
      page: json['page'],
    );
  }
}
