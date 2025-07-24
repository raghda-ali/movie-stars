import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String profilePath;
  final String knownForDepartment;
  final double popularity;

  const PersonEntity({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.knownForDepartment,
    required this.popularity,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    profilePath,
    knownForDepartment,
    popularity,
  ];
}
