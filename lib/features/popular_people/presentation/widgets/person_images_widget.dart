import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_stars/core/constants/router_paths.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';

class PersonImagesWidget extends StatelessWidget {
  const PersonImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        mainAxisExtent: 160,
      ),
      itemCount: popularPeopleBloc.personImagesResponse!.profiles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder:
          (_, index) => GestureDetector(
            onTap: () {
              context.push(
                RouterPaths.fullPersonImage,
                extra: {
                  'imageUrl':
                      popularPeopleBloc
                          .personImagesResponse!
                          .profiles[index]
                          .filePath,
                  'width':
                      popularPeopleBloc
                          .personImagesResponse!
                          .profiles[index]
                          .width,
                  'height':
                      popularPeopleBloc
                          .personImagesResponse!
                          .profiles[index]
                          .height,
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${popularPeopleBloc.personImagesResponse!.profiles[index].filePath}',
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => const Center(
                      child: CircularProgressIndicator(color: Colors.grey),
                    ),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
    );
  }
}
