import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';

class PersonBasicInfoPage extends StatelessWidget {
  final int personId;

  const PersonBasicInfoPage({super.key, required this.personId});

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    popularPeopleBloc.add(GetPersonBasicInfo(personId: personId));
    return Scaffold(
      appBar: AppBar(
        title: Text(popularPeopleBloc.personBasicInfo?.name ?? "Loading.."),
      ),
      body: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
        builder: (context, state) {
          if (state is GetPersonBasicInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${popularPeopleBloc.personBasicInfo!.profilePath}',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                      errorWidget:
                          (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                  Text(popularPeopleBloc.personBasicInfo!.name),
                  Text(popularPeopleBloc.personBasicInfo!.knownForDepartment!),
                  Text(
                    'Birthday: ${popularPeopleBloc.personBasicInfo!.birthday}',
                  ),
                  Text(
                    'Place of birth: ${popularPeopleBloc.personBasicInfo!.placeOfBirth}',
                  ),
                  if (popularPeopleBloc
                      .personBasicInfo!
                      .alsoKnownAs!
                      .isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Also known as:'),
                        ...popularPeopleBloc.personBasicInfo!.alsoKnownAs!.map(
                          (name) => Text('- $name'),
                        ),
                      ],
                    ),
                  if (popularPeopleBloc.personBasicInfo!.biography != null) ...[
                    Text('Description'),
                    Text(popularPeopleBloc.personBasicInfo!.biography!),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
