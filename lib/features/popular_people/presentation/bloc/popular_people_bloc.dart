import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_stars/features/popular_people/data/models/person_model.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_popular_people_use_case.dart';

part 'popular_people_event.dart';
part 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  final GetPopularPeopleUseCase getPopularPeopleUseCase;
  List<PersonEntity> popularPeople = [];
  PopularPeopleBloc({required this.getPopularPeopleUseCase})
    : super(GetPopularPeopleInitial()) {
    on<GetPopularPeople>((event, emit) async {
      emit(GetPopularPeopleLoading());
      final errorOrDone = await getPopularPeopleUseCase();
      errorOrDone.fold(
        (error) {
          emit(GetPopularPeopleFailure(errorMessage: error.toString()));
        },
        (done) {
          popularPeople = done;
          emit(GetPopularPeopleSuccess());
        },
      );
    });
  }
}
