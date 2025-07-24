import 'package:movie_stars/features/popular_people/domain/entities/person_image_entity.dart';

class PersonImageModel extends PersonImageEntity {
  const PersonImageModel({
    required super.filePath,
    super.width,
    super.height,
  });

  factory PersonImageModel.fromJson(Map<String, dynamic> json) {
    return PersonImageModel(
      filePath: json['file_path'],
      width: json['width'],
      height: json['height'],
    );
  }
}
