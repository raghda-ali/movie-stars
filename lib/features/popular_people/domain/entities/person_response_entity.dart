import 'package:movie_stars/features/popular_people/data/models/person_model.dart';

class PersonResponseEntity {
  final List<PersonModel> results;
  final int totalPages;
  final int page;

  PersonResponseEntity({
    required this.results,
    required this.totalPages,
    required this.page,
  });
}