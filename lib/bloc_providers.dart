import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:movie_stars/service_locator.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<PopularPeopleBloc>(
    create: (context) => ServiceLocator.getIt<PopularPeopleBloc>(),
  ),
];
