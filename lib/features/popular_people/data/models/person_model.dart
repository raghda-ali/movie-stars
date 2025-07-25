import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required super.id,
    required super.name,
    super.profilePath,
    super.knownForDepartment,
    super.popularity,
    super.biography,
    super.birthday,
    super.deathDay,
    super.placeOfBirth,
    super.alsoKnownAs,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path']??'',
      knownForDepartment: json['known_for_department']??'',
      popularity: (json['popularity'] as double),
      biography: json['biography'],
      birthday: json['birthday'],
      deathDay: json['deathday'],
      placeOfBirth: json['place_of_birth'],
      alsoKnownAs: List<String>.from(json['also_known_as'] ?? []),
    );
  }
}
