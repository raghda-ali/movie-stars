import 'package:equatable/equatable.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_image_entity.dart';

class PersonImagesResponseEntity extends Equatable {
  final List<PersonImageEntity> profiles;

  const PersonImagesResponseEntity({required this.profiles});

  @override
  List<Object?> get props => [profiles];
}
