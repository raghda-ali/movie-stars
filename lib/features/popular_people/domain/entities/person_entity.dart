import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String? profilePath;
  final String? knownForDepartment;
  final double? popularity;
  final String? biography;
  final String? birthday;
  final String? deathDay;
  final String? placeOfBirth;
  final List<String>? alsoKnownAs;

  const PersonEntity({
    required this.id,
    required this.name,
    this.profilePath,
    this.knownForDepartment,
    this.popularity,
    this.biography,
    this.birthday,
    this.deathDay,
    this.alsoKnownAs,
    this.placeOfBirth,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    profilePath,
    knownForDepartment,
    popularity,
    birthday,
    biography,
    deathDay,
    alsoKnownAs,
    placeOfBirth,
  ];
}
