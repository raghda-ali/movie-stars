part of 'popular_people_bloc.dart';

sealed class PopularPeopleState extends Equatable {
  const PopularPeopleState();

  @override
  List<Object> get props => [];
}

final class GetPopularPeopleInitial extends PopularPeopleState {}

class GetPopularPeopleLoading extends PopularPeopleState {}

class GetPopularPeopleSuccess extends PopularPeopleState {}

class GetPopularPeopleFailed extends PopularPeopleState {
  final String errorMessage;

  const GetPopularPeopleFailed({required this.errorMessage});
}

class LoadMorePopularPeopleLoading extends PopularPeopleState {}

class LoadMorePopularPeopleSuccess extends PopularPeopleState {}

class LoadMorePopularPeopleFailed extends PopularPeopleState {
  final String errorMessage;

  const LoadMorePopularPeopleFailed({required this.errorMessage});
}

class GetPersonBasicInfoLoading extends PopularPeopleState {}

class GetPersonBasicInfoSuccess extends PopularPeopleState {}

class GetPersonBasicInfoFailed extends PopularPeopleState {
  final String errorMessage;

  const GetPersonBasicInfoFailed({required this.errorMessage});
}

class GetPersonImagesLoading extends PopularPeopleState {}

class GetPersonImagesSuccess extends PopularPeopleState {}

class GetPersonImagesFailed extends PopularPeopleState {
  final String errorMessage;

  const GetPersonImagesFailed({required this.errorMessage});
}

class SavePersonImageSuccess extends PopularPeopleState {}

class SavePersonImageFailed extends PopularPeopleState {
  final String errorMessage;

  const SavePersonImageFailed({required this.errorMessage});
}
