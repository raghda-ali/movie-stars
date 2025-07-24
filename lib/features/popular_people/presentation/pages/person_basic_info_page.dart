import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:movie_stars/features/popular_people/presentation/widgets/person_images_widget.dart';

class PersonBasicInfoPage extends StatelessWidget {
  final int personId;

  const PersonBasicInfoPage({super.key, required this.personId});

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    popularPeopleBloc.add(GetPersonBasicInfo(personId: personId));
    popularPeopleBloc.add(GetPersonImages(personId: personId));
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
          builder: (context, state) {
            return Text(popularPeopleBloc.personBasicInfo?.name ?? "Loading..");
          },
        ),
      ),
      body: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
        builder: (context, state) {
          if (state is GetPersonBasicInfoLoading ||
              state is GetPersonImagesLoading ||
              popularPeopleBloc.personBasicInfo == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 20),
                  Text(
                    popularPeopleBloc.personBasicInfo!.name,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    popularPeopleBloc.personBasicInfo!.knownForDepartment!,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Birthday: ${popularPeopleBloc.personBasicInfo!.birthday}',
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Place of birth: ${popularPeopleBloc.personBasicInfo!.placeOfBirth}',
                  ),
                  SizedBox(height: 10),
                  if (popularPeopleBloc
                      .personBasicInfo!
                      .alsoKnownAs!
                      .isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Also known as:',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ...popularPeopleBloc.personBasicInfo!.alsoKnownAs!.map(
                          (name) => Text('- $name'),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  if (popularPeopleBloc.personBasicInfo!.biography != null) ...[
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(popularPeopleBloc.personBasicInfo!.biography!),
                  ],
                  SizedBox(height: 20),
                  Text(
                    'Images',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                PersonImagesWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
