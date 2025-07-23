part of 'popular_people_bloc.dart';

sealed class PopularPeopleEvent extends Equatable {
  const PopularPeopleEvent();

  @override
  List<Object> get props => [];
}

class GetPopularPeople extends PopularPeopleEvent {}
