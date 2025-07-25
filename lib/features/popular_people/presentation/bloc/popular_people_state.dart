part of 'popular_people_bloc.dart';

enum RequestStatus { initial, loading, success, error }

class PopularPeopleState extends Equatable {
  final RequestStatus popularPeopleStatus;
  final RequestStatus loadMorePeopleStatus;
  final RequestStatus personBasicInfoStatus;
  final RequestStatus personImagesStatus;
  final RequestStatus savePersonImageStatus;

  final String? popularPeopleError;
  final String? loadMoreError;
  final String? personBasicInfoError;
  final String? personImagesError;
  final String? savePersonImageError;

  const PopularPeopleState({
    this.popularPeopleStatus = RequestStatus.initial,
    this.loadMorePeopleStatus = RequestStatus.initial,
    this.personBasicInfoStatus = RequestStatus.initial,
    this.personImagesStatus = RequestStatus.initial,
    this.savePersonImageStatus = RequestStatus.initial,
    this.popularPeopleError,
    this.loadMoreError,
    this.personBasicInfoError,
    this.personImagesError,
    this.savePersonImageError,
  });

  PopularPeopleState copyWith({
    RequestStatus? popularPeopleStatus,
    RequestStatus? loadMoreStatus,
    RequestStatus? personBasicInfoStatus,
    RequestStatus? personImagesStatus,
    RequestStatus? savePersonImageStatus,
    String? popularPeopleError,
    String? loadMoreError,
    String? personBasicInfoError,
    String? personImagesError,
    String? savePersonImageError,
  }) {
    return PopularPeopleState(
      popularPeopleStatus: popularPeopleStatus ?? this.popularPeopleStatus,
      loadMorePeopleStatus: loadMoreStatus ?? loadMorePeopleStatus,
      personBasicInfoStatus: personBasicInfoStatus ?? this.personBasicInfoStatus,
      personImagesStatus: personImagesStatus ?? this.personImagesStatus,
      savePersonImageStatus: savePersonImageStatus ?? this.savePersonImageStatus,
      popularPeopleError: popularPeopleError ?? this.popularPeopleError,
      loadMoreError: loadMoreError ?? this.loadMoreError,
      personBasicInfoError: personBasicInfoError ?? this.personBasicInfoError,
      personImagesError: personImagesError ?? this.personImagesError,
      savePersonImageError: savePersonImageError ?? this.savePersonImageError,
    );
  }

  @override
  List<Object?> get props => [
    popularPeopleStatus,
    loadMorePeopleStatus,
    personBasicInfoStatus,
    personImagesStatus,
    savePersonImageStatus,
    popularPeopleError,
    loadMoreError,
    personBasicInfoError,
    personImagesError,
    savePersonImageError,
  ];
}
