import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_person_basic_info_use_case.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_popular_people_use_case.dart';

part 'popular_people_event.dart';
part 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  final GetPopularPeopleUseCase getPopularPeopleUseCase;
  final GetPersonBasicInfoUseCase getPersonBasicInfoUseCase;
  List<PersonEntity> popularPeople = [];
  List<PersonEntity> loadedPopularPeople = [];
  bool hasMorePeople = true;
  int currentPopularPeoplePage = 2;
PersonEntity? personBasicInfo;
  PopularPeopleBloc({
    required this.getPopularPeopleUseCase,
    required this.getPersonBasicInfoUseCase,
  }) : super(GetPopularPeopleInitial()) {
    on<GetPopularPeople>((event, emit) async {
      emit(GetPopularPeopleLoading());
      final errorOrDone = await getPopularPeopleUseCase(page: event.page);
      errorOrDone.fold(
        (error) {
          emit(GetPopularPeopleFailed(errorMessage: error.toString()));
        },
        (done) {
          popularPeople = done;
          emit(GetPopularPeopleSuccess());
        },
      );
    });
    on<LoadMorePopularPeople>((event, emit) async {
      emit(LoadMorePopularPeopleLoading());
      final errorOrDone = await getPopularPeopleUseCase(page: event.page);
      errorOrDone.fold(
        (error) {
          emit(LoadMorePopularPeopleFailed(errorMessage: error.toString()));
        },
        (done) {
          loadedPopularPeople = done;
        },
      );
      final Set<int> currentEventsIds =
          popularPeople.map((event) => event.id).toSet();
      final allLoadedEvents = loadedPopularPeople.where(
        (event) => !currentEventsIds.contains(event.id),
      );

      popularPeople.addAll(allLoadedEvents);
      currentPopularPeoplePage++;
      if (popularPeople.length < 15) {
        hasMorePeople = false;
      }
      emit(LoadMorePopularPeopleSuccess());
    });
    on<GetPersonBasicInfo>((event, emit) async {
      emit(GetPersonBasicInfoLoading());
      final errorOrDone = await getPersonBasicInfoUseCase(personId: event.personId,);
      errorOrDone.fold(
        (error) {
          emit(GetPersonBasicInfoFailed(errorMessage: error.toString()));
        },
        (done) {
          personBasicInfo = done;
          emit(GetPersonBasicInfoSuccess());
        },
      );
    });
  }
}
