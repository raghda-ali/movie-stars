import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required super.id,
    required super.name,
    required super.profilePath,
    required super.knownForDepartment,
    required super.popularity,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
      knownForDepartment: json['known_for_department'] ?? '',
      popularity: (json['popularity'] as double),
    );
  }
}
