import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:movie_stars/core/constants/router_paths.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';

import '../widgets/custom_item_widget.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    popularPeopleBloc.add(GetPopularPeople(page: 1));
    return Scaffold(
      appBar: AppBar(title: const Text('Popular People'), centerTitle: true),
      body: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
        builder: (context, state) {
          final itemCount =
              popularPeopleBloc.hasMorePeople
                  ? popularPeopleBloc.popularPeople.length + 1
                  : popularPeopleBloc.popularPeople.length;
          if (state is GetPopularPeopleLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          } else if (popularPeopleBloc.popularPeople.isEmpty) {
            return const Center(child: Text('No Popular People Now'));
          }
          return ListView.builder(
            itemCount: itemCount,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index < popularPeopleBloc.popularPeople.length) {
                return LazyLoadingList(
                  initialSizeOfItems: 15,
                  index: index,
                  loadMore: () async {
                    if (popularPeopleBloc.popularPeople.length > 15) {
                      popularPeopleBloc.add(
                        LoadMorePopularPeople(
                          page: popularPeopleBloc.currentPopularPeoplePage,
                        ),
                      );
                      await Future.delayed(const Duration(seconds: 1));
                    }
                  },
                  hasMore: popularPeopleBloc.hasMorePeople,
                  child: CustomItemWidget(
                    title: popularPeopleBloc.popularPeople[index].name,
                    subTitle:
                        popularPeopleBloc
                            .popularPeople[index]
                            .knownForDepartment!,
                    image:
                        'https://image.tmdb.org/t/p/w500${popularPeopleBloc.popularPeople[index].profilePath!}',
                    onTap: () {
                      context.push(
                        RouterPaths.personBasicInfoPath(
                          '${popularPeopleBloc.popularPeople[index].id}',
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: Colors.grey),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
