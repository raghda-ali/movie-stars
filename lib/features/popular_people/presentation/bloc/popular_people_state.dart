part of 'popular_people_bloc.dart';
sealed class PopularPeopleState extends Equatable {
  const PopularPeopleState();

  @override
  List<Object> get props => [];
}

final class GetPopularPeopleInitial extends PopularPeopleState {}

class GetPopularPeopleLoading extends PopularPeopleState {}

class GetPopularPeopleSuccess extends PopularPeopleState {}

class GetPopularPeopleFailure extends PopularPeopleState {
  final String errorMessage;

  const GetPopularPeopleFailure({required this.errorMessage,});
}

