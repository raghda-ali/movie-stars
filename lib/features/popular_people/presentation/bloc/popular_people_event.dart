part of 'popular_people_bloc.dart';

sealed class PopularPeopleEvent extends Equatable {
  const PopularPeopleEvent();

  @override
  List<Object> get props => [];
}

class GetPopularPeople extends PopularPeopleEvent {
  final int page;

  const GetPopularPeople({required this.page});
}

class LoadMorePopularPeople extends PopularPeopleEvent {
  final int page;

  const LoadMorePopularPeople({required this.page});
}
