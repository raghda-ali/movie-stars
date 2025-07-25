import 'package:movie_stars/features/popular_people/data/models/person_image_model.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_images_response_entity.dart';

class PersonImagesResponseModel extends PersonImagesResponseEntity {
  const PersonImagesResponseModel({required super.profiles});
  factory PersonImagesResponseModel.fromJson(Map<String, dynamic> json) {
    final profiles =
        (json['profiles'] as List<dynamic>)
            .map((item) => PersonImageModel.fromJson(item))
            .toList();

    return PersonImagesResponseModel(profiles: profiles);
  }
}
