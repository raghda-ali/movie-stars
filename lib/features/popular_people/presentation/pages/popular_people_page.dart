import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    popularPeopleBloc.add(GetPopularPeople());
    return Scaffold(
      appBar: AppBar(title: const Text('Popular People'), centerTitle: true),
      body: ListView.builder(
        itemCount: popularPeopleBloc.popularPeople.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://image.tmdb.org/t/p/w500${popularPeopleBloc.popularPeople[index].profilePath}',
              ),
            ),
            title: Text(popularPeopleBloc.popularPeople[index].name),
            subtitle: Text(
              popularPeopleBloc.popularPeople[index].knownForDepartment,
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
