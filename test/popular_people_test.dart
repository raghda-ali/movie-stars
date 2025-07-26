import 'package:flutter/cupertino.dart';
import 'package:mockito/annotations.dart';
import 'package:movie_stars/core/network/network_info.dart';
import 'package:movie_stars/core/services/dio_service.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/local_data_source/people_local_data_source.dart';
import 'package:movie_stars/features/popular_people/data/data_sources/remote_data_source/people_remote_data_source.dart';
import 'package:movie_stars/features/popular_people/domain/repositories/people_repository.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';

@GenerateMocks([PeopleRepository, PopularPeopleBloc,DioService,PeopleRemoteDataSource,PeopleLocalDataSource,NetworkInfo])
void main() {}
