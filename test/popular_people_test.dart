import 'package:mockito/annotations.dart';
import 'package:movie_stars/core/services/dio_service.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';

@GenerateMocks([PeopleRepository, PopularPeopleBloc,DioService])
void main() {}
