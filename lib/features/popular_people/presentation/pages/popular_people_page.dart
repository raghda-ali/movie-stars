import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:movie_stars/core/constants/router_paths.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import '../widgets/custom_item_widget.dart';

class PopularPeoplePage extends StatefulWidget {
  const PopularPeoplePage({super.key});

  @override
  State<PopularPeoplePage> createState() => _PopularPeoplePageState();
}

class _PopularPeoplePageState extends State<PopularPeoplePage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularPeopleBloc>().checkConnection();
    context.read<PopularPeopleBloc>().add(GetPopularPeople(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Popular People'), centerTitle: true),
      body: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
        builder: (context, state) {
          if (state.popularPeopleStatus == RequestStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          } else if (state.popularPeopleStatus == RequestStatus.error) {
            return const Center(
              child: Text('Something Error, try again later'),
            );
          } else if (popularPeopleBloc.popularPeople?.results.isEmpty == true) {
            return const Center(child: Text('No Popular People Now'));
          } else if (state.popularPeopleStatus == RequestStatus.success &&
              popularPeopleBloc.popularPeople != null) {
            return ListView.builder(
              itemCount:
                  popularPeopleBloc.hasMorePeople
                      ? popularPeopleBloc.popularPeople!.results.length + 1
                      : popularPeopleBloc.popularPeople!.results.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index < popularPeopleBloc.popularPeople!.results.length) {
                  return LazyLoadingList(
                    index: index,
                    loadMore: () async {
                      if (popularPeopleBloc.hasMorePeople &&
                          index ==
                              popularPeopleBloc.popularPeople!.results.length -
                                  1) {
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
                      title:
                          popularPeopleBloc.popularPeople!.results[index].name,
                      subTitle:
                          popularPeopleBloc
                              .popularPeople!
                              .results[index]
                              .knownForDepartment!,
                      image:
                          'https://image.tmdb.org/t/p/w500${popularPeopleBloc.popularPeople!.results[index].profilePath ?? ''}',
                      onTap: () async {
                        context.push(
                          RouterPaths.personBasicInfoPath(
                            '${popularPeopleBloc.popularPeople!.results[index].id}',
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
          }
          return SizedBox();
        },
      ),
    );
  }
}
